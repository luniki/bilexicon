class Example < ActiveRecord::Base
  belongs_to :exampleable, :polymorphic => true

  validates_presence_of :form1, :form2
end
