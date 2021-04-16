class Subject < ApplicationRecord
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
  has_many :exams, dependent: :destroy
end
