class AddIndicesToCategories < ActiveRecord::Migration
  def self.up
    add_index :categories, :lft
    add_index :categories, :rgt
  end

  def self.down
      remove_index :categories, :lft
      remove_index :categories, :rgt
  end
end
