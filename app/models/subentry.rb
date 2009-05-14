class Subentry < ActiveRecord::Base
  belongs_to :lemma
  has_many :examples, :as => :exampleable,
                      :dependent => :destroy,
                      :order => "position"

  acts_as_taggable_on :meanings
  acts_as_list :scope => :lemma

  validates_presence_of :form1, :form2
end
