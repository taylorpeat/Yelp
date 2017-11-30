class AddUniqueIndexToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, [:business_id, :user_id], unique: true
  end
end
