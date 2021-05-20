class Exam < ApplicationRecord
  belongs_to :subject
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions
  has_many :user_exams, dependent: :destroy
  scope :questions_sort_by_created_at_asc, (lambda do |exam|
    exam.questions.order(created_at: :asc)
  end)
  delegate :name, to: :subject, prefix: true
end
