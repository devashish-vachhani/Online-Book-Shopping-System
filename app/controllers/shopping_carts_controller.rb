class ShoppingCartsController < ApplicationController
  load_and_authorize_resource
  def show
    @cart = current_user.shopping_cart
    @cart_items = @cart.shopping_cart_items if @cart.present? && @cart.shopping_cart_items.present?
  end

  def destroy
    @cart = current_user.shopping_cart
    @cart.clear
    redirect_to shopping_cart_path
  end
end