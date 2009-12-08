Factory.define :lemma do |lemma|

  lemma.short1 "drive"
  lemma.short2 "fahren"

  lemma.long1 "to drive"
  lemma.long2 "fahren"

  lemma.phonetic1 "ħüſĸær ðũ"
  lemma.phonetic2 "ĸjẽŧıł"

  lemma.word_class1 "V"
  lemma.word_class2 "V"

  lemma.level_rezeptiv "A1"
  lemma.level_produktiv "A1"

  lemma.categories {|category| [category.association(:category)]}
end

Factory.define :noun, :parent => :lemma do |noun|
  noun.word_class1 "N"
  noun.word_class2 "N"
end

Factory.define :verb, :parent => :lemma do |noun|
  noun.word_class1 "V"
  noun.word_class2 "V"
end

Factory.define :adjective, :parent => :lemma do |noun|
  noun.word_class1 "ADJ"
  noun.word_class2 "ADJ"
end

