class AddPositionToCategorizations < ActiveRecord::Migration
  def self.up
    add_column :categorizations, :id, :primary_key
    add_column :categorizations, :position, :integer
    Category.find(:all).each do |category|
      category.categorizations.each_with_index do |categorization, index|
        categorization.position = index + 1
        categorization.save!
      end
    end
  end

  def self.down
    remove_column :categorizations, :position
    remove_column :categorizations, :id
  end
end
