class RemoveOldWordClassField < ActiveRecord::Migration
  def self.up
    execute "UPDATE lemmata SET word_class1 = word_class, word_class2 = word_class"
    remove_column :lemmata, :word_class
  end

  def self.down
    add_column :lemmata, :word_class, :string
    execute "UPDATE lemmata SET word_class = word_class1"
  end
end
