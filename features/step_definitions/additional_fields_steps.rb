Given /^there is a (noun|verb|adjective)$/ do |word_class|
  @lemma = Factory.create(word_class)
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

Given /^a female noun$/ do
  @lemma = Factory.create(:noun, :gender1 => "f", :gender2 => "f")
end

Given /^the verb has a perfect with "(haben|sein)"$/ do |aux|
  @lemma["perfekt_#{aux}"] = true
  @lemma.save!
end

Given /^the verb's Partikel is trennbar$/ do
  @lemma["partikel_trennbar"] = true
  @lemma.save!
end

Given /^the verb has \-ge\-$/ do
  @lemma["hat_ge"] = true
  @lemma.save!
end

Given /^I am creating a new lemma$/ do
  visit new_lemma_path
end



When /^I visit the lemma's page$/ do
  visit lemma_path(@lemma)
end

When /^I set the word class to (noun|verb|adjective)$/ do |word_class|
  word_classes  = {"noun" => "N", "verb" => "V", "adjective" => "ADJ"}
  [1, 2].each do |side|
    select word_classes[word_class], :from => "lemma_word_class#{side}"
  end
end



Then /^the page should show the irregular (.*)$/ do |field|
  field.gsub! " ", "_"
  [1, 2].each do |side|
    response_body.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response_body.should have_tag "span.#{field}"
      end
    end
  end
end

Then /^the page should show the that the (?:noun|verb|adjective) is a (.*) (?:noun|verb|adjective)$/ do |field|
  [1, 2].each do |side|
    response_body.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response_body.should have_tag "span.#{field.gsub " ", "_"}"
      end
    end
  end
end

Then /^the page should say that the lemma is female$/ do
  [1, 2].each do |side|
    response_body.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response_body.should have_tag "span.gender", "f"
      end
    end
  end
end

Then /^the page should say that the lemma has perfect with "(haben|sein)"$/ do |aux|
  response_body.should have_tag "span.perfekt_#{aux}"
end

Then /^the page should say that the lemma's Partikel is trennbar$/ do
  response_body.should have_tag "span.partikel_trennbar"
end

Then /^the page should say that the lemma has \-ge\-$/ do
  response_body.should have_tag "span.hat_ge"
end

Then /^I should see fields with type:$/ do |table|
  table.hashes.each do |hash|
    field = hash['field'].gsub " ", "_"
    type = case hash['type']
          when "radio buttons": "radio"
          when "text fields":   "text"
          when "check boxes":   "checkbox"
    end

    [1, 2].each do |side|
      if Webrat.configuration.mode == :selenium
        selenium.should be_visible("css=input[type=#{type}][name^='lemma[#{field}#{side}']")
      else
        response_body.should have_tag "input[type=#{type}][name^='lemma[#{field}#{side}']"
      end
    end
  end
end

Then /^I should see (check boxes|radio buttons) on the German half for:$/ do |type, table|
  table.hashes.each do |hash|
    field = hash['field'].gsub " ", "_"
    input_type = case type
      when "check boxes":   "checkbox"
      when "radio buttons": "radio"
    end

    if Webrat.configuration.mode == :selenium
      selenium.should be_visible("css=input[type=#{input_type}][name^='lemma[#{field}']")
    else
      response_body.should have_tag "input[type=#{input_type}][name^='lemma[#{field}']"
    end
  end
end

