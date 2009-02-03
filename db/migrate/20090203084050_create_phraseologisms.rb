class CreatePhraseologisms < ActiveRecord::Migration
  def self.up
    create_table :phraseologisms do |t|
      t.integer :lemma_id
      t.string  :form1
      t.string  :form2

      t.timestamps
    end
  end

  def self.down
    drop_table :phraseologisms
  end
end
