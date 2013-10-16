require 'faker'

50.times do
  User.create(username: Faker::Name.name, password: "123", password_confirmation: "123")
end
