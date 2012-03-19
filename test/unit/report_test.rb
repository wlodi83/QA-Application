require 'test_helper'

class ReportTest < ActiveSupport::TestCase

  def setup
    time = Time.now.strftime("%Y%m%d")
    @daily_folder = "#{Rails.root}\\app\\assets\\files\\daily\\#{time}"
    @weekly_folder = "#{Rails.root}\\app\\assets\\files\\weekly\\#{time}"
    @monthly_folder = "#{Rails.root}\\app\\assets\\files\\monthly\\#{time}"

  end

  test "should generate daily folder" do
    assert_equal @daily_folder, Report.create_daily_folder
  end

  test "should generate weekly folder" do
    assert_equal @weekly_folder, Report.create_weekly_folder
  end

  test "should generate monthly folder" do
    assert_equal @monthly_folder, Report.create_monthly_folder
  end
end
