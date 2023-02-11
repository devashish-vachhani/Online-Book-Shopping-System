class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  validates :name, :author, :publisher, :price, :stock, presence: true

  def average_rating
    reviews.average(:rating)
  end

  ransacker :average_rating do
    Arel.sql('CAST((SELECT AVG(rating) FROM reviews WHERE reviews.book_id = books.id) AS FLOAT)')
  end
end
