class AddAnnotationToLemma < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :annotation1, :string
    add_column :lemmata, :annotation2, :string
  end

  def self.down
    remove_column :lemmata, :annotation2
    remove_column :lemmata, :annotation1
  end
end
