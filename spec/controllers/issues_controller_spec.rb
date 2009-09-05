require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssuesController do

  #Delete these examples and add some real ones
  it "should use IssuesController" do
    controller.should be_an_instance_of(IssuesController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "responding to POST create" do

    include EmailSpec::Helpers
    include EmailSpec::Matchers

    it "should deliver the signup email" do
      issue = {:title => "title", :body  => "body"}
      # expect
      IssueMailer.should_receive(:deliver_issue).with(issue)
      # when
      post :signup, :issue => issue
    end
  end
end
