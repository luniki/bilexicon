class AddSynonymsToLemmata < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :synonym1, :string
    add_column :lemmata, :synonym2, :string
  end

  def self.down
    remove_column :lemmata, :synonym1
    remove_column :lemmata, :synonym2
  end
end
