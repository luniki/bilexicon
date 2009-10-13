class Subentry < ActiveRecord::Base
  belongs_to :lemma, :validate => true
  has_many :examples, :as => :exampleable,
                      :dependent => :destroy,
                      :order => "position"

  acts_as_taggable_on :meanings
  acts_as_list :scope => :lemma

  validates_presence_of :form1, :form2

  after_save :set_lemma_delta_flag

  protected

  def set_lemma_delta_flag
    if lemma
      lemma.delta = true
      lemma.save
    end
  end
end
