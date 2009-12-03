class Categorization < ActiveRecord::Base
  belongs_to :lemma
  belongs_to :category
end
