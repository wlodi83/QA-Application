require 'exasol'

class Script < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :frequencies
  has_and_belongs_to_many :categories

  attr_accessor :frequency_list, :user_list, :category_list

  after_save :update_frequencies, :update_users, :update_categories

  def self.check_query(query)
    @query = query
    connection = Exasol.new('lwlodarczyk','lwl0d4rczyk')
    connection.connect
    connection.check_query(@query.id)
    connection.disconnect
  end

  def self.find_daily_scripts
    Script.joins(:frequencies).where("frequencies.name = 'daily' and scripts.err_message IS NULL and scripts.active = true")
  end

  def self.find_weekly_scripts
    Script.joins(:frequencies).where("frequencies.name = 'weekly' and scripts.err_message IS NULL and scripts.active = true")
  end

  def self.find_monthly_scripts
    Script.joins(:frequencies).where("frequencies.name = 'monthly' and scripts.err_message IS NULL and scripts.active = true")
  end

  def self.process_scripts(scripts, path)
    @scripts = scripts
    @path = path
    @scripts.each do |script|
      Script.process_script(script, path)
    end
  end

  def self.process_script(script, path)
    @users = User.find_script_users(script)
    @path = path
    @script = script
    @report_title = script.title
      if @script.email_form?
        @name_of_columns, @result_array = Report.return_database_result(@script)
        User.send_html_emails(@users, @name_of_columns, @result_array, @report_title)
      else
        @report_attachment_name, @path_to_excel_file = Report.create_excel_file(@script, @path)
        User.send_excel_emails(@users, @report_attachment_name, @path_to_excel_file, @report_title)
      end
    end

  private
  def update_frequencies
    frequencies.delete_all
    selected_frequencies = frequency_list.nil? ? [] : frequency_list.keys.collect{|id| Frequency.find_by_id(id)}
    selected_frequencies.each { |frequency| self.frequencies << frequency }
  end

  def update_users
    users.delete_all
    selected_users = user_list.nil? ? [] : user_list.keys.collect { |id| User.find_by_id(id) }
    selected_users.each { |user| self.users << user }
  end

  def update_categories
    categories.delete_all
    selected_categories = category_list.nil? ? [] : category_list.keys.collect { |id| Category.find_by_id(id) }
    selected_categories.each { |category| self.categories << category }
  end

end
