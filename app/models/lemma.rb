class Lemma < ActiveRecord::Base

  has_and_belongs_to_many :categories

  has_many :examples, :as => :exampleable,
                      :dependent => :destroy,
                      :order => "position"


  has_many :subentries,     :dependent => :destroy, :order => "position", :include => :examples
  has_many :valencies,      :dependent => :destroy, :order => "position", :include => :examples
  has_many :collocations,   :dependent => :destroy, :order => "position", :include => :examples
  has_many :phraseologisms, :dependent => :destroy, :order => "position", :include => :examples

  validates_presence_of :short1, :short2, :long1, :long2,
                        :word_class1, :word_class1,
                        :level_rezeptiv, :level_produktiv


  # define indices for the sphinx search engine
  define_index do
    indexes short1, short2, long1, long2, phonetic1, phonetic2,
            synonym1, synonym2

    # additional fields dependend on word class
    indexes [singular_genitive1, singular_genitive2,
             plural1,            plural2,
             female_form1,       female_form2,
             present_tense1,     present_tense2,
             past_tense1,        past_tense2,
             past_participle1,   past_participle2,
             comparative1,       comparative2,
             superlative1,       superlative2], :as => :additional_fields

    indexes examples.form1, :as => :examples_form1
    indexes examples.form2, :as => :examples_form2

    indexes subentries.form1, :as => :subentries_form1
    indexes subentries.form2, :as => :subentries_form2
    indexes subentries.synonym1, :as => :subentries_synonym1
    indexes subentries.synonym2, :as => :subentries_synonym2
    indexes subentries.examples.form1, :as => :subentries_examples_form1
    indexes subentries.examples.form2, :as => :subentries_examples_form2

  end

  GENDERS = %w(m f n)

  LEVELS = %w(A1 A2 B1 B2 C1 C2)

  WORD_CLASSES = %w(N V ADJ CL wh-clause CL-Rel ADV ADVtime ADVplace Prep PrepN P PRON ReflPRON)

  def level
    "#{level_rezeptiv}/#{level_produktiv}"
  end
end
