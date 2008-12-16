class Example < ActiveRecord::Base
  belongs_to :exampleable, :polymorphic => true
end
