require File.dirname(__FILE__) + '/../spec_helper'

describe "Issue Email" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before(:all) do
    @issue = {:title => "title", :body => "<script/>"}
    @email = IssueMailer.create_issue @issue
  end

  subject { @email }

  it "should have the issue's title in the subject" do
    should have_subject(/Issue: #{@issue[:title]}/)
  end

  it "should have the issue's body in the body" do
    should have_body_text "#{ERB::Util.h @issue[:body]}"
  end

  it "should deliver the issue to the site owner" do
    should deliver_to APP_CONFIG["site_owner"]["email"]
  end

end
