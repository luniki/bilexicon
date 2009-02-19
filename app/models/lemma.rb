class Lemma < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :examples, :as => :exampleable, :dependent => :destroy

  has_many :valencies, :dependent => :destroy

  has_many :collocations, :dependent => :destroy

  has_many :phraseologisms, :dependent => :destroy

  validates_presence_of :short1, :short2,
                        :word_class, :level_rezeptiv, :level_produktiv

  LEVELS = %w(A1 A2 B1 B2 C1 C2)

  WORD_CLASSES = %w(N V ADJ CL wh-clause CL-Rel ADV ADVtime ADVplace Prep PrepN P PRON ReflPRON)

  def self.search(search)
    find(:all,
         :conditions => ['short1 LIKE :q OR short2 LIKE :q OR ' +
                         'long1 LIKE :q OR long2 LIKE :q',
                         {:q => "%#{search}%"}],
         :order => 'short1 ASC, short2 ASC')
  end

  def level
    "#{level_rezeptiv}/#{level_produktiv}"
  end
end
