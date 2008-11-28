require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/new.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = stub_model(Lemma,
      :new_record? => true
    )
    assigns[:category] = stub_model(Category,
      :name => "a category name"
    )
  end

  it "should render new form" do
    render "/lemmata/new.html.erb"

    response.should have_tag("form[action=?][method=post]", lemmata_path) do
    end
  end
end

