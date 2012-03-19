require 'test_helper'

class ReportMailerTest < ActionMailer::TestCase

  tests ReportMailer
  test "send_email" do
    user = users(:lukasz)
    script = scripts(:active_daily)
    time = Time.now.strftime("%Y%m%d")
    file_path = "#{Rails.root}\\app\\assets\\files\\test\\test_attachment.txt"
    test_file = File.open("#{file_path}", 'w') do |f|
      f.write("test file attachment")
    end
    report_attachment_name = "test_attachment.txt"
    report_attachment_path = file_path
    report_title = script.title

    # Send the email, then test that it got queued
    email = ReportMailer.send_report_email(user.email, report_attachment_name, report_attachment_path, report_title).deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal 1, ActionMailer::Base.deliveries.size

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
    assert_match(/<body>\r\nYou can find your report in attached files\r\n<\/body>/, email.encoded)
  end
end
