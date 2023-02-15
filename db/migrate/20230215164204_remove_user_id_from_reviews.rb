class RemoveUserIdFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_reference :reviews, :user, null: false, foreign_key: true
    add_reference :reviews, :reviewable, polymorphic: true, null: false
  end
end
