class AddJoinTableForCategoriesAndLemmata < ActiveRecord::Migration
  def self.up
    create_table :categories_lemmata, :id => false do |t|
      t.column :category_id, :integer, :null => false
      t.column :lemma_id,  :integer, :null => false
    end
  end

  def self.down
    drop_table :categories_lemmata
  end
end
