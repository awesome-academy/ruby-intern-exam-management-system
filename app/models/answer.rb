class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :created_user
end
