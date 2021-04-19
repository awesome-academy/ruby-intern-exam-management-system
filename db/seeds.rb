User.create!(name: "Example User",
  email: "admin@gmail.com",
  password: "admin123",
  password_confirmation: "admin123",
  name: "Admin",
  role: 1)

5.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password,
      role: 2)
end

subject_list = ["Unit Test", "Ruby on Rails", "PHP"]
subject_list.each do |subject_name|
  Subject.create!(name: subject_name)
end

100.times do |n|
  content = Faker::Lorem.question(word_count: 10)
  question = Question.create!(content: content,
          choice_type: 1,
          subject_id: Subject.pluck(:id).sample)
  content = Faker::Lorem.sentence(word_count: 10)
  Answer.create!(
    content: content,
    correct: true,
    question_id: question.id
  )
  2.times do |m|
    content = Faker::Lorem.sentence(word_count: 10)
    Answer.create!(
      content: content,
      correct: false,
      question_id: question.id
    )
  end
end

100.times do |n|
  content = Faker::Lorem.question(word_count: 10)
  question = Question.create!(content: content,
          choice_type: 2,
          subject_id: Subject.pluck(:id).sample)
  3.times do |m|
    content = Faker::Lorem.sentence(word_count: 10)
    Answer.create!(
      content: content,
      correct: [true, false].sample,
      question_id: question.id
    )
  end
end
