class DropBusinessesTags < ActiveRecord::Migration
  def up
    drop_table("businesses_tags")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
