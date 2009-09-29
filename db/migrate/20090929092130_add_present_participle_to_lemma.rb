class AddPresentParticipleToLemma < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :present_participle1, :string
    add_column :lemmata, :present_participle2, :string
  end

  def self.down
    remove_column :lemmata, :present_participle1, :present_participle2
  end
end
