require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/new.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:category] = @category = stub_model(Category,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/categories/new.html.erb"

    response.should have_tag("form[action=?][method=post]", categories_path) do
      with_tag("input#category_name")
      with_tag("label[for=category_name]")
      with_tag("select#category_parent_id")
    end
  end

  describe "adding a root category" do

    it "should have a back link to the categories" do
      render "/categories/new.html.erb"

      response.should have_tag("a[href=#{categories_path}]",
                               :text => I18n.translate(:back))
    end

    it "should not preselect a parent category" do
      render "/categories/new.html.erb"

      response.should_not have_tag("select#category_parent_id option[selected]")
    end
  end

  describe "adding a subcategory" do

    before(:each) do
      assigns[:parent] = @parent = stub_model(Category, :id => 1)
    end

    it "should have a back link to the parent category" do
      render "/categories/new.html.erb"

      response.should have_tag("a[href=?]", category_path(@parent),
                               :text => I18n.translate(:back))
    end

    it "should preselect the parent category" do

      template.should_receive(:nested_set_options).and_return([["parent category", @parent.id]])

      render "/categories/new.html.erb"

      response.should have_tag("select#category_parent_id option[selected][value=?]", @parent.id)
    end

  end
end

