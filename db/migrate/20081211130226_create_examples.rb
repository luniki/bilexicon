class CreateExamples < ActiveRecord::Migration
  def self.up
    create_table :examples do |t|
      t.string :form1
      t.string :form2
      t.string :synonym1
      t.string :synonym2
      t.string :syntax1
      t.string :syntax2
      t.string :form2
      t.integer :exampleable_id
      t.string :exampleable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :examples
  end
end
