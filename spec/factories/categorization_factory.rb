Factory.define :categorization do |categorization|
  categorization.category {|categorization| categorization.association(:category)}
  categorization.lemma  {|categorization| categorization.association(:lemma)}
  categorization.sequence(:position) {|n| n}
end

Factory.define :invalid_categorization, :class => Categorization do |categorization|
end
