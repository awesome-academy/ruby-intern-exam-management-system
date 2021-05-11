FactoryBot.define do
  factory :user_exam do
    spent_time { 0 }
    user
    exam
  end
end
