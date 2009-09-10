# step definitions for learners

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

# irregular fields for nouns

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

# irregular fields for verbs

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

# editor step definitions

Given /^I am an editor$/ do
  @user = Factory(:editor)
  visit new_user_session_path
  response.should contain("Login")
  fill_in "Login", :with => @user.login
  fill_in "Password", :with => @user.password
  click_button "Login"
  response.should contain("Login successful!")
#  @editor = Factory(:editor)
#  assert @user_session = UserSession.create(@editor)
end

#require "ruby-debug"

Given /^I am creating a new lemma$/ do
  visit new_lemma_path
end


When /^I set the word class to (.+)$/ do |word_class|
#  breakpoint
  [1, 2].each {|side| select "N" , :from => "lemma_word_class#{side}" }
end

Then /^I should see (radio buttons|text fields|check boxes) for (.+)$/ do |type, field|

  field.gsub! " ", "_"

  selector = case type
        when "radio buttons": "input[type=radio]#?"
        when "text fields":   "input[type=text]#?"
        when "check boxes":   "input[type=checkbox]#?"
  end

  [1, 2].each do |side|
    response.should have_tag selector, /^lemma_#{field}#{side}/
  end
end

Then /^I should see a checkbox for (.+) on the German half$/ do |field|
  field.gsub! " ", "_"
  response.should have_tag "input[type=checkbox]#?", /^lemma_#{field}/
end

