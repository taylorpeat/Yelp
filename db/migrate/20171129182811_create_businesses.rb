class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :cover_image
      t.string :community
      t.string :street_address
      t.string :phone_number
      t.integer :price_range

      t.timestamps null: false
    end
  end
end
