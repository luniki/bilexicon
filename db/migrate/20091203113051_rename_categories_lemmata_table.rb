class RenameCategoriesLemmataTable < ActiveRecord::Migration
  def self.up
    rename_table :categories_lemmata, :categorizations
  end

  def self.down
    rename_table :categorizations, :categories_lemmata
  end
end
