class User < ActiveRecord::Base
  acts_as_authentic

  attr_protected :admin

  has_many :decks
end
