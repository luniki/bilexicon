class Collocation < ActiveRecord::Base
  belongs_to :lemma
  has_many :examples, :as => :exampleable, :dependent => :destroy

  validates_presence_of :form1, :form2, :syntax1, :syntax2
end
