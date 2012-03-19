class AlertMailer < ActionMailer::Base
  default from: "lukasz.wlodarczyk@sponsorpay.com"

  def send_alert(user_email, err_message)
    @user_email = user_email
    @err_message = err_message
    mail(:to => "#{@user_email}", :subject => "ALERT: QA Report from #{Time.now}")
  end
end
