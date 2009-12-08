module LemmataHelper

  def underline(text)
    text.gsub(/\b_([^_]+)_\b/) { |m| "<u>" + h($1) + "</u>" }
  end

  def formatted_word_class(side)
    locale = side == 1 ? :en : :de
    wc = @lemma["word_class#{side}"]
    "cl: %s" % h(I18n.translate("word_classes.#{wc}", :locale => locale))
  end

  # not so simple text attributes
  %w(singular_genitive plural female_form).each do |attribute|
    define_method("formatted_#{attribute}") do |side|
      locale = side == 1 ? :en : :de
      "%s: %s" % [I18n.translate("#{attribute}_abbr", :locale => locale), @lemma["#{attribute}#{side}"]]
    end
  end

  # simple boolean attributes
  %w(singular_only collective countable uncountable
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
