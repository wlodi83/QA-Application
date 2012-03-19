class ReportMailer < ActionMailer::Base
  default from: "lukasz.wlodarczyk@sponsorpay.com"

  def send_report_email(user_email, report_attachment_name, report_attachment_path, report_title)
    @user_email = user_email
    attachments["#{report_attachment_name}"] = File.open("#{report_attachment_path}", 'rb'){|f| f.read}
    mail(:to => "#{@user_email}", :subject => "QA Report: #{report_title} from #{Time.now}")
    end
end