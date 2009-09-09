require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssuesController do

  it_should_behave_like "an authenticated controller"

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "responding to POST create" do

    it "should deliver the signup email" do
      issue = {"title" => "title", "body"  => "body"}
      # expect
      IssueMailer.should_receive(:deliver_issue).with(issue)
      # when
      post :create, :issue => issue
    end
  end
end
