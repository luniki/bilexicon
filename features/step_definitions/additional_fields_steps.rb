Given /^there is a (noun|verb|adjective)$/ do |word_class|
  @lemma = Factory(word_class)
end

Given /^the (?:noun|verb|adjective) has an irregular (.*)$/ do |field|
  field.gsub! " ", "_"
  @lemma["#{field}1"] = @lemma["#{field}2"] = "irregular field"
  @lemma.save
end

Given /^the (?:noun|verb|adjective) is a (.*) (?:noun|verb|adjective)$/ do |field|
  field.gsub! " ", "_"
  @lemma["#{field}1"] = @lemma["#{field}2"] = true
  @lemma.save
end

When /^I visit the lemma's page$/ do
  visit lemma_path(@lemma)
end

Then /^the page should show the irregular (.*)$/ do |field|
  field.gsub! " ", "_"
  [1, 2].each do |side|
    response.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response.should have_tag "span.#{field}", "irregular field"
      end
    end
  end
end

Then /^the page should show the that the (?:noun|verb|adjective) is a (.*) (?:noun|verb|adjective)$/ do |field|
  [1, 2].each do |side|
    response.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response.should have_tag "span.#{field.gsub " ", "_"}", 1
      end
    end
  end
end



Given /^a female noun$/ do
  @lemma = Factory(:noun, :gender1 => "f", :gender2 => "f")
end

Then /^the page should say that the lemma is female$/ do
  [1, 2].each do |side|
    response.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response.should have_tag "span.gender", "f"
      end
    end
  end
end



Given /^the verb has a perfect with "(haben|sein)"$/ do |aux|
  @lemma["perfekt_#{aux}"] = true
  @lemma.save!
end

Then /^the page should say that the lemma has perfect with "(haben|sein)"$/ do |aux|
  response.should have_tag "span.perfekt_#{aux}"
end

Given /^the verb's Partikel is trennbar$/ do
  @lemma["partikel_trennbar"] = true
  @lemma.save!
end

Then /^the page should say that the lemma's Partikel is trennbar$/ do
  response.should have_tag "span.partikel_trennbar"
end

Given /^the verb has \-ge\-$/ do
  @lemma["hat_ge"] = true
  @lemma.save!
end

Then /^the page should say that the lemma has \-ge\-$/ do
  response.should have_tag "span.hat_ge"
end

