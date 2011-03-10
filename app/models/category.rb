class Category < ActiveRecord::Base

  has_many :categorizations, :dependent => :destroy
  has_many :lemmata, :through => :categorizations

  acts_as_nested_set

  validates_presence_of :name
end
