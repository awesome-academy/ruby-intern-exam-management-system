class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  enum status: {start: 0, unchecked: 1, checked: 2, testing: 3}
  scope :sort_by_created_at_desc, ->{order created_at: :desc}
  has_one :subject, through: :exam
  has_many :questions, through: :exam
  has_many :user_exam_answers, dependent: :destroy
  has_many :answers, through: :user_exam_answers
  accepts_nested_attributes_for :questions
end
