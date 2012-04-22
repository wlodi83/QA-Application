class User < ActiveRecord::Base
  has_and_belongs_to_many :scripts

  def self.find_script_users(script)
    User.uniq.joins(:scripts).where("scripts.id = ?", script.id)
  end

  def self.send_excel_emails(users, report_attachment_name, report_attachment_path, report_title)
    @users = users
    @report_attachment_name = report_attachment_name
    @report_attachment_path = report_attachment_path
    @report_title = report_title
    @users.each do |user|
      ReportMailer.send_excel_report_email(user, @report_attachment_name, @report_attachment_path, @report_title).deliver
    end
  end

  def self.send_html_emails(users, name_of_columns, result_array, report_title)
    @users = users
    @name_of_columns = name_of_columns
    @result_array = result_array
    @report_title = report_title
    @users.each do |user|
      ReportMailer.send_html_report_email(user, @name_of_columns, @result_array, @report_title).deliver
    end
  end
end
