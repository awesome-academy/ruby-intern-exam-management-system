class UserExamStatistic < ApplicationRecord
  has_many :user_exam_statistic_details, dependent: :destroy
end
