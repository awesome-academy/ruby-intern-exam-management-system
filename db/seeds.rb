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
  correct_indexes = [true, false, true].shuffle
  3.times do |m|
    content = Faker::Lorem.sentence(word_count: 10)
    Answer.create!(
      content: content,
      correct: correct_indexes[m],
      question_id: question.id
    )
  end
end

sub_ids_list = Subject.pluck :id
sub_ids_list.each do |sub_id|
  10.times do |n|
    Exam.create!(
      name: Faker::Lorem.sentence(word_count: 5),
      time: 20,
      subject_id: sub_id,
      total_number_questions: 10
    )
  end
end

exams_list = Exam.select :id, :subject_id, :total_number_questions
exams_list.each do |exam|
  questions = Question.where subject_id: exam.subject_id
  questions.sample(exam.total_number_questions).each do |question|
    ExamQuestion.create!(
      score: 10,
      question_id: question.id,
      exam_id: exam.id
    )
  end
end

5.times do |n|
  UserExam.create!(
    spent_time: 0,
    status: 0,
    exam_id: Exam.pluck(:id).sample,
    user_id: 2
  )
end
