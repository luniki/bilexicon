class Lemma < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :examples, :as => :exampleable

  validates_presence_of :short1, :short2

  def self.search(search)
    find(:all,
         :conditions => ['short1 LIKE :q OR short2 LIKE :q OR ' +
                         'long1 LIKE :q OR long2 LIKE :q',
                         {:q => "%#{search}%"}],
         :order => 'short1 ASC, short2 ASC')
  end
end
