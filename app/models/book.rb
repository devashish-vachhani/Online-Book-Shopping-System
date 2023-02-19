class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :nullify

  validates :name, :author, :publisher, :price, :stock, presence: true

  before_destroy :delete_related_shopping_cart_items


  def average_rating
    reviews.average(:rating)
  end

  ransacker :average_rating do
    Arel.sql('CAST((SELECT AVG(rating) FROM reviews WHERE reviews.book_id = books.id) AS FLOAT)')
  end

  def delete_related_shopping_cart_items
    ShoppingCartItem.where(item_id: id).destroy_all
  end
end
