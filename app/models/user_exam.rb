class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  enum status: {start: 0, unchecked: 1, checked: 2, testing: 3}
  scope :sort_by_created_at_desc, ->{order created_at: :desc}
  has_one :subject, through: :exam
end
