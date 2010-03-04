Given /^a category named "([^\"]*)"$/ do |name|
  @category = Factory.create(:category, :name => name)
  pp @category
end

Then /^I should see a button to create a new deck$/ do
  response_body.should have_tag "form[action=?]", deck_path
end

