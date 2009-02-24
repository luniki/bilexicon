class AddSynonymsFieldToSubentries < ActiveRecord::Migration
  def self.up
    %w(examples valencies collocations phraseologisms).each do |table|
      add_column table, :synonym1, :string
      add_column table, :synonym2, :string
    end
  end

  def self.down
    %w(examples valencies collocations phraseologisms).each do |table|
      remove_column table, :synonym1
      remove_column table, :synonym2
    end
  end
end
