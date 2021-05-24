FactoryBot.define do
  factory :answer do
    question
    content { Faker::Lorem.sentence(word_count: 10) }
    correct { false }
  end
end
