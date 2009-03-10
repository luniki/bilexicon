require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/index.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:categories] = [
      stub_model(Category, :name => "category 1"),
      stub_model(Category, :name => "category 2")
    ]
  end

  it "should render list of top categories" do
    render "/categories/index.html.erb"

    response.should have_tag("ul#categories") do
      with_tag("li.category", :count => assigns[:categories].size) do
        assigns[:categories].each do |category|
          with_tag("a[href=?]", category_path(category), :text => category.name)
        end
      end
    end
  end

  describe "for authorized users" do
    it_should_behave_like "an admin-authorized view"

    it "should have a link to add another category" do
      render "/categories/index.html.erb"
      response.should have_tag("a[href=?]", new_category_path)
    end
  end
end

