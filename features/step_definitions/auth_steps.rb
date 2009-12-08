Before('@authenticated') do
  Given "I am a user"
end

Given /^I am an editor$/ do
  @user ||= Factory.create(:editor)
  visit new_user_session_path
  response.should contain("Login")
  fill_in "Login", :with => @user.login
  fill_in "Password", :with => @user.password
  click_button "Login"
  response.should contain("Login successful!")
end

Given /^I am a user$/ do
  @user ||= Factory.create(:user)
  visit new_user_session_path
  response.should contain("Login")
  fill_in "Login", :with => @user.login
  fill_in "Password", :with => @user.password
  click_button "Login"
  response.should contain("Login successful!")
end

