class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers, dependent: :destroy
  enum choice_type: {single: 1, multiple: 2}
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
  validates :content, presence: true,
            length: {maximum: Settings.question.content.max_length}
  validates :choice_type, presence: true
end
