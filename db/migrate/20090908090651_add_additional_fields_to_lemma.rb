class AddAdditionalFieldsToLemma < ActiveRecord::Migration
  def self.up

    [1, 2].each do |side|
      add_column :lemmata, "gender#{side}",            :string
      add_column :lemmata, "singular_genitive#{side}", :string
      add_column :lemmata, "plural#{side}",            :string
      add_column :lemmata, "singular_only#{side}",     :boolean
      add_column :lemmata, "collective#{side}",        :boolean
      add_column :lemmata, "compound#{side}",          :boolean
      add_column :lemmata, "female_form#{side}",       :string

      add_column :lemmata, "auxiliary#{side}",          :boolean
      add_column :lemmata, "present_tense#{side}",     :string
      add_column :lemmata, "past_tense#{side}",        :string
      add_column :lemmata, "past_participle#{side}",   :string
      add_column :lemmata, "reflexive#{side}",    :boolean
      add_column :lemmata, "regular#{side}",      :boolean
      add_column :lemmata, "irregular#{side}",    :boolean
      add_column :lemmata, "transitive#{side}",   :boolean
      add_column :lemmata, "intransitive#{side}", :boolean

      add_column :lemmata, "comparative#{side}",       :string
      add_column :lemmata, "superlative#{side}",       :string
      add_column :lemmata, "predicative#{side}",       :boolean
      add_column :lemmata, "attributive#{side}",       :boolean
    end

    add_column :lemmata, :perfekt_haben,     :boolean
    add_column :lemmata, :perfekt_sein,      :boolean
    add_column :lemmata, :partikel_trennbar, :boolean
    add_column :lemmata, :hat_ge,            :boolean

  end

  def self.down

    [1, 2].each do |side|
      remove_columns :lemmata, "gender#{side}", "singular_genitive#{side}",
                               "plural#{side}", "singular_only#{side}",
                               "collective#{side}", "compound#{side}",
                               "female_form#{side}",

                               "auxiliary#{side}", "present_tense#{side}",
                               "past_tense#{side}", "past_participle#{side}",
                               "reflexive#{side}", "regular#{side}",
                               "irregular#{side}",
                               "transitive#{side}",
                               "intransitive#{side}",

                               "comparative#{side}", "superlative#{side}",
                               "predicative#{side}", "attributive#{side}"
    end

    remove_columns :lemmata, :perfekt_haben, :perfekt_sein,
                             :partikel_trennbar, :hat_ge
  end
end
