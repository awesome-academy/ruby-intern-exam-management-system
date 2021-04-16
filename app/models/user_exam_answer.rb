class UserExamAnswer < ApplicationRecord
  belongs_to :answer, class_name: Answer.name, foreign_key: :user_answer_id
  belongs_to :user_exam
  delegate :correct, to: :answer
end
