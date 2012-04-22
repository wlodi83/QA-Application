class ReportMailer < ActionMailer::Base
  default from: "lukasz.wlodarczyk@sponsorpay.com"

  def send_excel_report_email(user, report_attachment_name, report_attachment_path, report_title)
    @user_email = user.email
    @user_name = user.name
    @report_title = report_title
    attachments["#{report_attachment_name}"] = File.open("#{report_attachment_path}", 'rb'){|f| f.read}
    mail(:to => "#{@user_email}", :subject => "QA Report: #{@report_title} from #{Time.now}")
  end

  def send_html_report_email(user, name_of_columns, result_array, report_title)
    @user_email = user.email
    @name_of_columns = name_of_columns
    @user_name = user.name
    @result_array = result_array
    @report_title = report_title
    mail(:to => "#{@user_email}", :subject => "QA Report: #{@report_title} from #{Time.now}")
  end

end