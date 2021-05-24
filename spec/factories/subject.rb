FactoryBot.define do
  sequence :name do |n|
    "Subject #{n}"
  end

  factory :subject do
    name { generate(:name) }

    factory :create_subject_with_questions_list do
      transient do
        questions_count { 10 }
      end

      after(:create) do |subject, evaluator|
        create_list(:create_question_with_answers_list, evaluator.questions_count, subject: subject)
        subject.reload
      end
    end
  end
end
