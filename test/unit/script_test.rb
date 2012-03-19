require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
   test "should find daily scripts" do
     daily_script = Script.find_daily_scripts
     script = scripts(:active_daily)
     assert_equal 1, daily_script.size
     assert_equal script, daily_script[0]
   end

   test "should find weekly scripts" do
     weekly_script = Script.find_weekly_scripts
     script = scripts(:active_weekly)
     assert_equal 1, weekly_script.size
     assert_equal script, weekly_script[0]
   end

  test "should find monthly scripts" do
    monthly_script = Script.find_monthly_scripts
    script = scripts(:active_monthly)
    assert_equal 1, monthly_script.size
    assert_equal script, monthly_script[0]
  end
end
