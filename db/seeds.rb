User.create!(name: "admin",
            email: "admin@framgia.com",
            password: "123456",
            password_confirmation: "123456",
            role: 0)

10.times do |n|
  name  = "FELS#{n+1}"
  email = "FELS#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password)
end

10.times do |n|
  name  = "Category #{n}"
  description = "Description-#{n}"
  Category.create!(name:  name,
               description: description)
end
