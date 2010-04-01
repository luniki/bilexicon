Given /^the following lemma exists:$/ do |table|
  table.hashes.each do |hash|
    attributes = {}
    hash.each {|k, v| attributes[k.gsub(' ','').underscore] = v}
    @lemma = Factory.create(:lemma, attributes)
  end
end

Given /^a lemma with the following (valencies|collocations|phraseologisms) exists:$/ do |type, table|
  @lemma = Factory.create(:lemma)
  table.hashes.each do |hash|
    attributes = {}
    hash.each {|k, v| attributes[k.gsub(' ','').underscore] = v}
    @lemma.send(type) << Factory.create(type.singularize.to_sym, hash)
  end
  @lemma.save!
end

Given /^a lemma of level "([ABC][12])\/([ABC][12])" exists$/ do |rezeptiv, produktiv|
  @lemma = Factory.create(:noun, :level_rezeptiv => rezeptiv, :level_produktiv => produktiv)
end

When /^I start editing inline$/ do
  visit lemma_path(@lemma)
  selenium.mouse_over "css=div.entry-line"
  selenium.click "css=div.entry-line a.multi-button"
  selenium.click "css=li.cmd-editLemma"
end

When /^I submit the inline edit form$/ do
  selenium.click("css=.entry-edit button.submit")
end

Then /^I should see underlined text in field "(.*)"$/ do |field|
  Then %{I should see /.+/ within "#{field} u"}
end

Then /^I should see underlined text in the header$/ do
  Then %{I should see /.+/ within ".lemma h1 .short u"}
  Then %{I should see /.+/ within ".lemma h1 .short + .short u"}
end

