class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  acts_as_shopping_cart

  def tax_pct
    0
  end
end