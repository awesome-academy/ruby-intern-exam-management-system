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
