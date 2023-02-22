FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 5) }
    password_confirmation { |u| u.password }
    phone_number { Faker::Number.number(digits: 10) }
    credit_card_number { Faker::Number.number(digits: 16) }
  end
end