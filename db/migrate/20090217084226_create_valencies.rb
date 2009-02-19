class CreateValencies < ActiveRecord::Migration
  def self.up
    create_table :valencies do |t|
      t.integer :lemma_id
      t.string  :form1
      t.string  :form2

      t.timestamps
    end
  end

  def self.down
    drop_table :valencies
  end
end
