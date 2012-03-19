require 'exasol'
require 'excel'

class Report < ActiveRecord::Base

  @@time = Time.now.strftime("%Y%m%d")

  def self.create_daily_folder
    folder = "#{Rails.root}\\app\\assets\\files\\daily\\#{@@time}"
    path = FileUtils.mkdir_p "#{folder}"
    return path[0]
  end

  def self.create_weekly_folder
    folder = "#{Rails.root}\\app\\assets\\files\\weekly\\#{@@time}"
    path = FileUtils.mkdir_p "#{folder}"
    return path[0]
  end

  def self.create_monthly_folder
    folder = "#{Rails.root}\\app\\assets\\files\\monthly\\#{@@time}"
    path = FileUtils.mkdir_p "#{folder}"
    return path[0]
  end

  def self.generate_daily_report
    @path = Report.create_daily_folder
    @scripts = Script.find_daily_scripts
    @connection = Exasol.new('*********','*********')
    @connection.connect
    Script.process_scripts(@scripts, @path)
    @connection.disconnect
  end

  def self.generate_weekly_report
    @path = Report.create_weekly_folder
    @scripts = Script.find_weekly_scripts
    @connection = Exasol.new('lwlodarczyk','lwl0d4rczyk')
    @connection.connect
    Script.process_scripts(@scripts, @path)
    @connection.disconnect
  end

  def self.generate_monthly_report
    @path = Report.create_monthly_folder
    @scripts = Script.find_monthly_scripts
    @connection = Exasol.new('lwlodarczyk','lwl0d4rczyk')
    @connection.connect
    Script.process_scripts(@scripts, @path)
    @connection.disconnect
  end

  def self.create_excel_file(script, path)
    @path = path
    @excel_file_name = "#{script.title.downcase.gsub(/[^a-zA-Z0-9]+/, '_').gsub(/-{2,}/, '_').gsub(/^-|-$/, '')}.xls"
    @path_to_excel_file = "#{@path}\\#{@excel_file_name}"
    @connection.do_query(script)
    #create excel file
    @exc = Excel.new("#{@path_to_excel_file}")
    @exc.create_worksheets(1)
    @column_names = @connection.print_column_names
    @number_of_headers = @connection.return_number_of_headers
    @exc.create_headers(@number_of_headers, @column_names)
    @content = @connection.print_result_array
    @exc.create_excel_content(@content)
    @exc.close
    return @excel_file_name, @path_to_excel_file
  end
end