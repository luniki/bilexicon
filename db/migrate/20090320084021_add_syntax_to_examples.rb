class AddSyntaxToExamples < ActiveRecord::Migration
  def self.up
    add_column :examples, :syntax1, :string
    add_column :examples, :syntax2, :string
  end

  def self.down
    remove_column :examples, :syntax1
    remove_column :examples, :syntax2
  end
end
