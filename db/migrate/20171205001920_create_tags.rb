class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :businesses_tags do |t|
      t.belongs_to :businesses, index: true
      t.belongs_to :tags, index: true
      t.timestamps
    end
  end
end
