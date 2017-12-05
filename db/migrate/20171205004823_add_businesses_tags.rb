class AddBusinessesTags < ActiveRecord::Migration
  def change
    create_table :businesses_tags do |t|
      t.belongs_to :business, index: true
      t.belongs_to :tag, index: true
      t.timestamps
    end
  end
end
