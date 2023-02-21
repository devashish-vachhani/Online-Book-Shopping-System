require 'faker'

FactoryBot.define do
  factory :shopping_cart_item do
    association :owner, factory: :shopping_cart
    association :item, factory: :book
    quantity { Faker::Number.between(from: 1, to: 10) }
    price_cents { Faker::Number.between(from: 100, to: 1000) }
    price_currency { 'USD' }
  end
end