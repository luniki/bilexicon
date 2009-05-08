class Example < ActiveRecord::Base
  belongs_to :exampleable, :polymorphic => true

  acts_as_list :scope => :exampleable

  validates_presence_of :form1, :form2
end
