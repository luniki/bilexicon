class CreateSubentries < ActiveRecord::Migration
  def self.up

    create_table :subentries, :force => true do |t|

      t.integer  "lemma_id"
      t.string   "type"

      t.string   "form1"
      t.string   "form2"
      t.string   "syntax1"
      t.string   "syntax2"
      t.string   "synonym1"
      t.string   "synonym2"

      t.timestamps
    end

  end

  def self.down
    drop_table :subentries
  end
end
