FactoryBot.define do
  factory :exam do
    subject
    name { Faker::Name.name }
  end
end
