class Exam < ApplicationRecord
  belongs_to :subject
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
end
