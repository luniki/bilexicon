require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/index.html.erb" do
  include LemmataHelper
  
  before(:each) do
    assigns[:lemmata] = [
      stub_model(Lemma),
      stub_model(Lemma)
    ]
  end

  it "should render list of lemmata" do
    render "/lemmata/index.html.erb"
  end
end

