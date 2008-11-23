require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/edit.html.erb" do
  include LemmataHelper
  
  before(:each) do
    assigns[:lemma] = @lemma = stub_model(Lemma,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/lemmata/edit.html.erb"
    
    response.should have_tag("form[action=#{lemma_path(@lemma)}][method=post]") do
    end
  end
end


