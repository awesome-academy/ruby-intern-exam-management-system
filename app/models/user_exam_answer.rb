class UserExamAnswer < ApplicationRecord
  belongs_to :user_answer
  belongs_to :user_exam
end
