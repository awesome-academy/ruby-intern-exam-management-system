set :environment, "development"
set :output, "log/cron_job.log"

every :day, at: "12:00 am" do
  runner "UserExamStatisticJob.perform_later DateTime.yesterday"
end

every :day, at: "12:30 pm" do
  runner "AdminMailer.statistic_done_user_exams(DateTime.yesterday).deliver_later"
end
