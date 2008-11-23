require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/show.html.erb" do
  include CategoriesHelper
  
  before(:each) do
    assigns[:category] = @category = stub_model(Category)
  end

  it "should render attributes in <p>" do
    render "/categories/show.html.erb"
  end
end

