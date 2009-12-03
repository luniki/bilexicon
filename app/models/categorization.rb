class Categorization < ActiveRecord::Base
  belongs_to :lemma
  belongs_to :category

  acts_as_list :scope => :category
end
