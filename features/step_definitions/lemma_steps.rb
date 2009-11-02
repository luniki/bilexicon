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

