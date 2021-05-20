class UserExamStatisticJob < ApplicationJob
  queue_as :high
  sidekiq_options retry: 5

  def perform datetime
    UserExamStatistic.transaction do
      user_exam_statistic = UserExamStatistic.create!(
        date: datetime.to_date,
        total_done_exams: UserExam.checked.done_on_date(datetime).size
      )
      UserExamStatisticDetail.transaction do
        subjects = Subject.all
        subjects.each do |subject|
          UserExamStatisticDetail.create!(
            user_exam_statistic: user_exam_statistic,
            subject: subject,
            count: subject.user_exams.checked.done_on_date(datetime).size
          )
        end
      end
    end
  end
end
