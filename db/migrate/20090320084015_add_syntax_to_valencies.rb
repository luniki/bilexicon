class AddSyntaxToValencies < ActiveRecord::Migration
  def self.up
    add_column :valencies, :syntax1, :string
    add_column :valencies, :syntax2, :string
  end

  def self.down
    remove_column :valencies, :syntax1
    remove_column :valencies, :syntax2
  end
end
