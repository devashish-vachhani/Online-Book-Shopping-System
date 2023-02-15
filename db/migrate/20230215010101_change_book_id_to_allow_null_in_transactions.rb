class ChangeBookIdToAllowNullInTransactions < ActiveRecord::Migration[7.0]
  def up
    change_column :transactions, :book_id, :integer, null: true
  end

  def down
    change_column :transactions, :book_id, :integer, null: false
  end
end
