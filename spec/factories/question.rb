FactoryBot.define do
  factory :question do
    subject
    content { Faker::Lorem.sentence(word_count: 10) }
    choice_type { Question.choice_types[:single] }

    factory :create_question_with_answers_list do
      transient do
        answers_count { 3 }
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question)
        question.reload
      end
    end
  end
end
