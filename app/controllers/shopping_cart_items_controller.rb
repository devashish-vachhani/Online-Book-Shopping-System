class ShoppingCartItemsController < ApplicationController
  # load_and_authorize_resource
  def new
    @shopping_cart_item = ShoppingCartItem.new
    if @book.nil?
      @book = Book.find(params[:book_id])
    end
  end

  def create
    @book = Book.find(params[:shopping_cart_item][:book_id])
    @shopping_cart = current_user.shopping_cart || current_user.create_shopping_cart
    @shopping_cart_item = @shopping_cart.shopping_cart_items.new(item: @book, quantity: params[:shopping_cart_item][:quantity], price: @book.price)

    if @shopping_cart_item.save
      @book.update(stock: @book.stock - @shopping_cart_item.quantity)
      redirect_to shopping_cart_path
    else
      render :new
    end
  end

  def destroy
    @shopping_cart_item = ShoppingCartItem.find(params[:id])
    @shopping_cart = current_user.shopping_cart
    @book = @shopping_cart_item.item
    if @shopping_cart_item.destroy
      @book.update(stock: @book.stock + @shopping_cart_item.quantity)
    end
    redirect_to shopping_cart_path
  end
end
