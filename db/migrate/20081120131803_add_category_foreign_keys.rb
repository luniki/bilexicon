class AddCategoryForeignKeys < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :category_id, :integer
  end

  def self.down
    remove_column :lemmata, :category_id
  end
end
