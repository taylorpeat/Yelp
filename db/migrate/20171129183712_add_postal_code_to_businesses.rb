class AddPostalCodeToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :postal_code, :string
  end
end
