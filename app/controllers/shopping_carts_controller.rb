class ShoppingCartsController < ApplicationController
  load_and_authorize_resource
  def show
    @shopping_cart = current_user.shopping_cart
    @shopping_cart_items = @shopping_cart.shopping_cart_items if @shopping_cart.present? && @shopping_cart.shopping_cart_items.present?
  end

  def destroy
    @shopping_cart = current_user.shopping_cart
    @shopping_cart.shopping_cart_items.each do |shopping_cart_item|
      @book = shopping_cart_item.item
      @book.update(stock: @book.stock + shopping_cart_item.quantity)
    end
    @shopping_cart.clear
    redirect_to shopping_cart_path
  end
end