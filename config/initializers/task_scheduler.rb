require 'rubygems'
require 'rufus/scheduler'

#require other classes which you want to use. Example any model or helper class which has implementation of required task

scheduler = Rufus::Scheduler.start_new

#every day of the week at 5 o'clock
scheduler.cron '00 05 * * 1-5' do
  Report.generate_daily_report
end

#every week at 6 o'clock
scheduler.cron '00 06 * * 0' do
  Report.generate_weekly_report
end

#every month at 6 o'clock
scheduler.cron '00 06 * * 7' do
  Report.generate_monthly_report
end