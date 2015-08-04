User.create!(name: "admin",
            email: "admin@framgia.com",
            password: "123456",
            password_confirmation: "123456",
            role: 0)

User.create!(name: "teacher",
            email: "teacher@framgia.com",
            password: "123456",
            password_confirmation: "123456",
            role: 1)

100.times do |n|
  name  = Faker::Name.name
  email = "FELS#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password)
end

100.times do |n|
  name  = Faker::Name.title
  description = Faker::Lorem.paragraphs(5).join("-")
  Category.create!(name:  name,
               description: description)
end
