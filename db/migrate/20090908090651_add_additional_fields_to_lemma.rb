class AddAdditionalFieldsToLemma < ActiveRecord::Migration
  def self.up
    add_column :lemmata, :gender,            :string
    add_column :lemmata, :singular_genitive, :string
    add_column :lemmata, :plural,            :string
    add_column :lemmata, :singular_only,     :boolean
    add_column :lemmata, :collective_noun,   :boolean
    add_column :lemmata, :compound,          :boolean
    add_column :lemmata, :female_form,       :string

    add_column :lemmata, :aux_verb,          :boolean
    add_column :lemmata, :present_tense,     :string
    add_column :lemmata, :past_tense,        :string
    add_column :lemmata, :past_participle,   :string
    add_column :lemmata, :perfekt_haben,     :boolean
    add_column :lemmata, :perfekt_sein,      :boolean
    add_column :lemmata, :reflexive_verb,    :boolean
    add_column :lemmata, :regular_verb,      :boolean
    add_column :lemmata, :irregular_verb,    :boolean
    add_column :lemmata, :partikel_trennbar, :boolean
    add_column :lemmata, :hat_ge,            :boolean
    add_column :lemmata, :transitive_verb,   :boolean
    add_column :lemmata, :intransitive_verb, :boolean

    add_column :lemmata, :comparative,       :string
    add_column :lemmata, :superlative,       :string
    add_column :lemmata, :predicative,       :boolean
    add_column :lemmata, :attributive,       :boolean
  end

  def self.down
    remove_columns :lemmata, :gender, :singular_genitive, :plural,
                   :singular_only, :collective_noun, :compound, :female_form,

                   :aux_verb, :present_tense, :past_tense, :past_participle,
                   :perfekt_haben, :perfekt_sein, :reflexive_verb,
                   :regular_verb, :irregular_verb, :partikel_trennbar, :hat_ge,
                   :transitive_verb, :intransitive_verb,

                   :comparative, :superlative, :predicative, :attributive
  end
end
