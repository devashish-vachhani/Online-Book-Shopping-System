class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item

  def price_in_dollars
    price_cents.to_f / 100
  end

end