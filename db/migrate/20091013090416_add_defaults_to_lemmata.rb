class AddDefaultsToLemmata < ActiveRecord::Migration
  def self.up
    [1, 2].each do |side|
      change_column :lemmata, "predicative#{side}", :boolean, :default => true
      change_column :lemmata, "attributive#{side}", :boolean, :default => true
    end
  end

  def self.down
    [1, 2].each do |side|
      change_column :lemmata, "predicative#{side}", :boolean, :default => nil
      change_column :lemmata, "attributive#{side}", :boolean, :default => nil
    end
  end
end
