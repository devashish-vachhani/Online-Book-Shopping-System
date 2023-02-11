class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.text :address
      t.string :phone_number
      t.integer :quantity
      t.float :total_price

      t.timestamps
    end
  end
end
