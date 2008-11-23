require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/index.html.erb" do
  include CategoriesHelper
  
  before(:each) do
    assigns[:categories] = [
      stub_model(Category),
      stub_model(Category)
    ]
  end

  it "should render list of categories" do
    render "/categories/index.html.erb"
  end
end

