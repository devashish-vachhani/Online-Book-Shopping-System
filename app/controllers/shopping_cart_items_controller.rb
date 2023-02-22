class ShoppingCartItemsController < ApplicationController
  load_and_authorize_resource
  def new
    @shopping_cart_item = ShoppingCartItem.new
    @book ||= Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:shopping_cart_item][:book_id])
    @shopping_cart = current_user.shopping_cart || current_user.create_shopping_cart
    @shopping_cart_item = @shopping_cart.shopping_cart_items.new(item: @book, quantity: params[:shopping_cart_item][:quantity], price: @book.price)

    respond_to do |format|
      if @shopping_cart_item.save
        format.html { redirect_to shopping_cart_path, notice: "Book was successfully added to cart." }
        format.json { render :show, status: :created, location: @shopping_cart }
      else
        @book = Book.find(params[:shopping_cart_item][:book_id])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shopping_cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @shopping_cart_item = ShoppingCartItem.find(params[:id])
    @book ||= @shopping_cart_item.item
  end

  def update
    respond_to do |format|
      if @shopping_cart_item.update(shopping_cart_item_params)
        format.html { redirect_to shopping_cart_path, notice: "Book was successfully updated in cart." }
        format.json { render :show, status: :created, location: @shopping_cart }
      else
        @book = Book.find(params[:shopping_cart_item][:book_id])
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shopping_cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shopping_cart_item = ShoppingCartItem.find(params[:id])
    @shopping_cart = current_user.shopping_cart
    if @shopping_cart_item.destroy
      redirect_to shopping_cart_path
    end
  end

  def shopping_cart_item_params
    params.require(:shopping_cart_item).permit(:quantity, :book_id, :book_name, :total_price)
  end
end
