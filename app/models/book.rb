class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :nullify
  has_many :shopping_cart_items, as: :item, dependent: :destroy

  validates :name, :author, :publisher, :price, :stock, presence: true
  validates :stock, :price, numericality: { greater_than_or_equal_to: 0 }


  def average_rating
    reviews.average(:rating)
  end

  ransacker :average_rating do
    Arel.sql('CAST((SELECT AVG(rating) FROM reviews WHERE reviews.book_id = books.id) AS FLOAT)')
  end

end
