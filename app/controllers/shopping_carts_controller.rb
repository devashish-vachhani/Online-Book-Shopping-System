class ShoppingCartsController < ApplicationController
  load_and_authorize_resource
  def show
    @shopping_cart = current_user.shopping_cart || current_user.create_shopping_cart
    @shopping_cart_items = @shopping_cart.shopping_cart_items if @shopping_cart.present? && @shopping_cart.shopping_cart_items.present?
  end

  def destroy
    @shopping_cart = current_user.shopping_cart
    @shopping_cart.clear
    redirect_to shopping_cart_path
  end
end