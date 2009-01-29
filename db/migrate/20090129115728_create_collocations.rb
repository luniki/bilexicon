class CreateCollocations < ActiveRecord::Migration
  def self.up
    create_table :collocations do |t|
      t.integer :lemma_id
      t.string  :form1
      t.string  :form2
      t.string  :syntax1
      t.string  :syntax2

      t.timestamps
    end
  end

  def self.down
    drop_table :collocations
  end
end
