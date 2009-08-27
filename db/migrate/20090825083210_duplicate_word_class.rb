class DuplicateWordClass < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :word_class1, :string
    add_column :lemmata, :word_class2, :string
  end

  def self.down
    remove_column :lemmata, :word_class1
    remove_column :lemmata, :word_class2
  end
end
