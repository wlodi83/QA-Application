class User < ActiveRecord::Base
  has_and_belongs_to_many :scripts

  def self.find_script_users(script)
    User.uniq.select(:email).joins(:scripts).where("scripts.id = ?", script.id)
  end

  def self.send_emails(users, report_attachment_name, report_attachment_path, report_title)
    @users = users
    @report_attachment_name = report_attachment_name
    @report_attachment_path = report_attachment_path
    @report_title = report_title
    @users.each do |user|
      ReportMailer.send_report_email(user.email, @report_attachment_name, @report_attachment_path, @report_title).deliver
    end
  end
end
