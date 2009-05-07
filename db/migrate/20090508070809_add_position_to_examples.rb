class AddPositionToExamples < ActiveRecord::Migration
  def self.up
    add_column :examples, :position, :integer
  end

  def self.down
    remove_column :examples, :position
  end
end
