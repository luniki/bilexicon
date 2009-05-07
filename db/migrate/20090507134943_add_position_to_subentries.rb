class AddPositionToSubentries < ActiveRecord::Migration
  def self.up
    add_column :subentries, :position, :integer
  end

  def self.down
    remove_column :subentries, :position
  end
end
