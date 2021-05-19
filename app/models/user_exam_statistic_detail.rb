class UserExamStatisticDetail < ApplicationRecord
  belongs_to :user_exam_statistic
  belongs_to :subject
  delegate :name, to: :subject, prefix: true
end
