FactoryBot.define do
  sequence :name do |n|
    "Subject #{n}"
  end

  factory :subject do
    name { generate(:name) }
  end
end
