class AddCountableToLemmata < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :countable1,   :boolean, :default => true
    add_column :lemmata, :countable2,   :boolean, :default => true
    add_column :lemmata, :uncountable1, :boolean
    add_column :lemmata, :uncountable2, :boolean
  end

  def self.down
    remove_column :lemmata, :countable1, :countable2, :uncountable1, :uncountable2
  end
end
