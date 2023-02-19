class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  acts_as_shopping_cart

  def tax_pct
    0
  end

  def book_in_cart?(book)
    shopping_cart_items.exists?(item: book)
  end
end