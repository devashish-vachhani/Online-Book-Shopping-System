class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [1, 2, 3, 4, 5], message: "%{value} is not a valid rating" }
end
