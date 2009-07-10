class AddIndexToCategoriesLemmata < ActiveRecord::Migration
  def self.up
    add_index :categories_lemmata, [:category_id, :lemma_id]
  end

  def self.down
    remove_index :categories_lemmata, [:category_id, :lemma_id]
  end
end
