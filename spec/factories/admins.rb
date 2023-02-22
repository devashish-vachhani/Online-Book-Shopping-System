FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { Faker::Internet.password(min_length: 5) }
    password_confirmation { |u| u.password }
  end
end