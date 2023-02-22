FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
    price { Faker::Commerce.price(range: 0..1000) }
    stock { Faker::Number.between(from: 0, to: 1000) }
  end
end