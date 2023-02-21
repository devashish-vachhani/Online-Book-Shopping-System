FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { "password" }
    password_confirmation { "password" }
  end
end