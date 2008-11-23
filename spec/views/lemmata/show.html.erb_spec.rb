require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/show.html.erb" do
  include LemmataHelper
  
  before(:each) do
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render attributes in <p>" do
    render "/lemmata/show.html.erb"
  end
end

