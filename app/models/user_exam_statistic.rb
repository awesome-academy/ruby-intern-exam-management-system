class UserExamStatistic < ApplicationRecord
  has_many :user_exam_statistic_details, dependent: :destroy
  scope :statistic_on_date, ->(date){where "date(date) = date(?)", date}
end
