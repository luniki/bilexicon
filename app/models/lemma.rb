class Lemma < ActiveRecord::Base
  belongs_to :category
  has_many :examples, :as => :exampleable

  validates_presence_of :short1, :short2, :category_id
end
