json.extract! transaction, :id, :credit_card_number, :address, :phone_number, :quantity, :total_price, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
