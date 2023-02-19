require 'securerandom'

class TransactionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    if current_user.id != nil
      @transactions = Transaction.where(user_id: current_user.id)
    end
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction_number = SecureRandom.hex(10)
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    sold_out_books = []

    ActiveRecord::Base.transaction do
      book_ids = current_user.shopping_cart.shopping_cart_items.map(&:item_id)
      books = Book.where(id: book_ids).lock(true)
      shopping_cart_items = current_user.shopping_cart.shopping_cart_items.to_a

      # check if all requested books are available
      unless shopping_cart_items.all? { |cart_item| cart_item.quantity <= books.find(cart_item.item_id).stock }
        sold_out_books = shopping_cart_items.select { |cart_item| cart_item.quantity > books.find(cart_item.item_id).stock }
        raise ActiveRecord::Rollback, "One or more books are no longer available in the requested quantities"
      end

      shopping_cart_items.each do |cart_item|
        book = books.find(cart_item.item_id)
        book.update!(stock: book.stock - cart_item.quantity)
        item_transaction = Transaction.new(
          transaction_number: @transaction.transaction_number,
          user: current_user,
          book: book,
          address: @transaction.address,
          phone_number: @transaction.phone_number,
          credit_card_number: @transaction.credit_card_number,
          quantity: cart_item.quantity,
          total_price: cart_item.price_in_dollars * cart_item.quantity
        )
        unless item_transaction.valid?
          item_transaction.errors.full_messages.each do |msg|
            @transaction.errors.add(:base, msg)
          end
          raise ActiveRecord::Rollback
        end
        item_transaction.save!
      end

      current_user.shopping_cart.shopping_cart_items.destroy_all
    end

  rescue ActiveRecord::Rollback => e

  ensure
    if sold_out_books.any?
      sold_out_books.each do |cart_item|
        book = Book.find(cart_item.item_id)
        msg = book.stock == 0 ? "#{book.name} is sold out" : "Only #{book.stock} copies of #{book.name} are available"
        flash[:alert] ||= ""
        flash[:alert] += "#{msg}. "
      end
      redirect_to shopping_cart_path, alert: flash[:alert]
    elsif @transaction.errors.any?
      @transaction_number = SecureRandom.hex(10)
      render :new
    else
      redirect_to transactions_path, notice: "Transaction was successfully created."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:transaction_number, :credit_card_number, :address, :phone_number)
    end
end
