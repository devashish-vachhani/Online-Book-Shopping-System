class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :phone_number, :string
    add_column :users, :credit_card_number, :string
  end
end
