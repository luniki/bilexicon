class AddIndexToExamples < ActiveRecord::Migration
  def self.up
    add_index :examples, [:exampleable_id, :exampleable_type]
  end

  def self.down
    remove_index :examples, [:exampleable_id, :exampleable_type]
  end
end
