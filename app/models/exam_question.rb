class ExamQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :exam
  has_many :answers, through: :question
end
