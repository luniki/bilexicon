module LemmataHelper

  def underline(text)
    text.gsub(/\b_([^_]+)_\b/) { |m| "<u>" + h($1) + "</u>" }
  end

  def formatted_singular_genitive(side)
    h "GenSing: #{@lemma["singular_genitive#{side}"]}"
  end

  def formatted_plural(side)
    h "Pl: #{@lemma["plural#{side}"]}"
  end

  def formatted_female_form(side)
    locale = side == 1 ? :en : :de
    "%s: %s" % [I18n.translate("female_form_abbr", :locale => locale), @lemma["female_form#{side}"]]
  end

  # simple boolean attributes
  %w(singular_only collective
     auxiliary reflexive regular irregular transitive intransitive
     predicative attributive).each do |attribute|
    define_method("formatted_#{attribute}") do |side|
      locale = side == 1 ? :en : :de
      I18n.translate(attribute, :locale => locale)
    end
  end

  # simple boolean attributes of only one side
  %w(perfekt_haben perfekt_sein partikel_trennbar hat_ge).each do |attribute|
    define_method("formatted_#{attribute}") do
      I18n.translate(attribute, :locale => :de)
    end
  end

  # simple text attributes
  %w(gender
     present_tense past_tense present_participle past_participle
     comparative superlative).each do |attribute|
    define_method("formatted_#{attribute}") {|side| @lemma["#{attribute}#{side}"]}
  end
end
