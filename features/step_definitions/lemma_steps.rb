# all steps related to lemmata

Given /^there is at least one lemma$/ do
  lemma = Lemma.new
  lemma.short1 = "to test"
  lemma.short2 = "testen"
  lemma.save
end

When /^I go to the home page$/ do
  visit "/"
end

Then /^I should see a search form$/ do
  response.body.should have_tag("form") do

  end
end

