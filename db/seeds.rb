User.create!(name: "Example User", email: "example@railstutorial.org",
  password: "foobar", password_confirmation: "foobar", gender: 1, admin: true)

49.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, gender: 1)
end

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+51}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, gender: 0)
end
