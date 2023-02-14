require 'securerandom'

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    if current_user.id != nil
      @transactions = Transaction.where(user_id: current_user.id)
    else
      @transactions = Transaction.all
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

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    current_user.shopping_cart.shopping_cart_items.each do |cart_item|
      Transaction.create(
        transaction_number: @transaction.transaction_number,
        user_id: @transaction.user_id,
        book_id: cart_item.item.id,
        address: @transaction.address,
        phone_number: @transaction.phone_number,
        credit_card_number: @transaction.credit_card_number,
        quantity: cart_item.quantity,
        total_price: cart_item.price_in_dollars * cart_item.quantity
      )
    end
    current_user.shopping_cart.shopping_cart_items.destroy_all
    redirect_to transactions_path, notice: "Transaction was successfully created."
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
