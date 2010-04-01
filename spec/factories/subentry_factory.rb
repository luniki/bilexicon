Factory.define :subentry do |subentry|
  subentry.form1 "to be"
  subentry.form2 "sein"

  subentry.syntax1 "V"
  subentry.syntax2 "V"

  subentry.synonym1 "a sample synomym"
  subentry.synonym2 "irgendein Synonym"
end

Factory.define :valency, :class => Valency, :parent => :subentry do
end
Factory.define :collocation, :class => Collocation, :parent => :subentry do
end
Factory.define :phraseologism, :class => Phraseologism, :parent => :subentry do
end
