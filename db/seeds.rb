User.create!(name: "Example User", email: "example@railstutorial.org",
  password: "foobar", password_confirmation: "foobar", gender: 1, admin: true,
  activated: true, activated_at: Time.zone.now)

49.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, gender: 1, activated: true,
    activated_at: Time.zone.now)
end

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+51}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, gender: 0, activated: true,
    activated_at: Time.zone.now)
end
