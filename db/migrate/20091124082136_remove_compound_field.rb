class RemoveCompoundField < ActiveRecord::Migration
  def self.up
    remove_column :lemmata, :compound1, :compound2
  end

  def self.down
    add_column :lemmata, :compound1, :boolean
    add_column :lemmata, :compound2, :boolean
  end
end
