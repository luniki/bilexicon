Given /^a category named "([^\"]*)"$/ do |name|
  @category = Factory.create(:category, :name => name)
end

Then /^I should see a link to create a new deck$/ do
  response_body.should have_tag "a[href=?]", new_user_deck_path(@user, :category_id => @category)
end

Then /^I should see a text field containing "([^\"]*)"$/ do |content|
  response_body.should have_tag "input[id=deck_name][value=?]", ERB::Util.html_escape(content)
end

Then /^I should see a a new deck named "([^\"]*)"$/ do |name|
  response_body.should have_tag "h1", /#{ERB::Util.html_escape(name)}/
end

When /^I create a new deck from the category "([^\"]*)"$/ do |name|
  When %{I go to the category "#{name}"}
  And %{I follow "create_deck"}
  And %{I press "create"}
end

