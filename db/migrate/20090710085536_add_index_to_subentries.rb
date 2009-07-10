class AddIndexToSubentries < ActiveRecord::Migration
  def self.up
    add_index :subentries, [:lemma_id, :type]
  end

  def self.down
    remove_index :subentries, [:lemma_id, :type]
  end
end
