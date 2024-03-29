class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :transaction_number, :quantity, :total_price, :address, :credit_card_number, :phone_number, presence: true
  validates :phone_number, length: { is: 10 }, numericality: { only_integer: true }
  validates :credit_card_number, length: { is: 16 }, numericality: { only_integer: true }
end
