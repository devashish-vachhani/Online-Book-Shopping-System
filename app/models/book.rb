class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :nullify
  validates :name, :author, :publisher, :price, :stock, presence: true
  validates_inclusion_of :price, :stock, in: 0..100000



  def average_rating
    reviews.average(:rating)
  end

  ransacker :average_rating do
    Arel.sql('CAST((SELECT AVG(rating) FROM reviews WHERE reviews.book_id = books.id) AS FLOAT)')
  end
end
