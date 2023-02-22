FactoryBot.define do
  factory :review do
    association :book, factory: :book
    association :reviewable, factory: :user
    # reviewable { association(:user) }
    rating { Faker::Number.between(from: 1, to: 5) }
    review { Faker::Lorem.paragraph }
  end
end