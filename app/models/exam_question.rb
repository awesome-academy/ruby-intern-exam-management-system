class ExamQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :exam
end
