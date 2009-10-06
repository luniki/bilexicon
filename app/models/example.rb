class Example < ActiveRecord::Base
  belongs_to :exampleable, :polymorphic => true

  acts_as_list :scope => :exampleable

  validates_presence_of :form1, :form2

  after_save :set_lemma_delta_flag


  private

  def set_lemma_delta_flag
    if exampleable.is_a?(Lemma)
      exampleable.delta = true
      exampleable.save
    else
      exampleable.set_lemma_delta_flag
    end
  end
end
