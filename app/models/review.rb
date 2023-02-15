class Review < ApplicationRecord
  belongs_to :book
  belongs_to :reviewable, polymorphic: true

  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [1, 2, 3, 4, 5], message: "%{value} is not a valid rating" }
  validates :review, presence: true

  ransacker :reviewable_username do
    Arel.sql("(SELECT username FROM users WHERE reviews.reviewable_type = 'User' AND users.id = reviews.reviewable_id UNION SELECT username FROM admins WHERE reviews.reviewable_type = 'Admin' AND admins.id = reviews.reviewable_id)")
  end
end
