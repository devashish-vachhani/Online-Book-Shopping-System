class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item

  validates :quantity, presence: true

  def price_in_dollars
    price_cents.to_f / 100
  end

  attr_accessor :book_name, :book_id, :total_price

end