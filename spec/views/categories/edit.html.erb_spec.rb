require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/edit.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:category] = @category = stub_model(Category,
      :name => "a name",
      :new_record? => false,
      :parent_id => 1
    )
  end

  it "should render edit form" do
    render "/categories/edit.html.erb"

    response.should have_tag("form[action=#{category_path(@category)}][method=post]") do
      with_tag("input#category_name[value=?]", @category.name)
      with_tag("select#category_parent_id")
    end
  end

  it "should have a back link" do
    render "/categories/edit.html.erb"

    response.should have_tag("a[href=#{category_path(@category)}]",
                             :text => I18n.translate(:back))
  end


  describe "and the edit form" do

    it "should have a dropdown box for the parent with a default item" do
      render "/categories/edit.html.erb"

      response.should have_tag("select#category_parent_id option:first-child[value='']")
    end

  end
end

