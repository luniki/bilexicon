class CreateLemmata < ActiveRecord::Migration
  def self.up
    create_table :lemmata do |t|
      t.string :short1
      t.string :short2
      t.string :long1
      t.string :long2
      t.string :phonetic1
      t.string :phonetic2
      t.string :word_class
      t.string :level_rezeptiv
      t.string :level_produktiv

      t.timestamps
    end
  end

  def self.down
    drop_table :lemmata
  end
end
