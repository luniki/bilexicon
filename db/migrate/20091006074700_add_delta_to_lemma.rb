class AddDeltaToLemma < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :delta, :boolean, :default => false
    add_index :lemmata, :delta
  end

  def self.down
    remove_column :lemmata, :delta
  end
end
