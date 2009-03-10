require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/show.html.erb" do
  include CategoriesHelper

  before(:each) do
    assigns[:ancestors] = @ancestors =
      [stub_model(Category, :name => "automobiles"),
       stub_model(Category, :name => "vans")]
    assigns[:category] = @category = stub_model(Category, :name => "microvans")
    assigns[:children] = @children =
      [stub_model(Category, :name => "Toyota Yaris"),
       stub_model(Category, :name => "Audi A2")]
    assigns[:lemmata] = @lemmata =
      [stub_model(Lemma, :short1 => "wheel", :short2 => "Rad"),
       stub_model(Lemma, :short1 => "light", :short2 => "Licht")]
  end

  it "should render the name of the category in h1" do
    render "/categories/show.html.erb"

    response.should have_tag("h1", @category.name)
  end

  it "should render a link to the virtual root ancestor" do
    render "/categories/show.html.erb"

    response.should have_tag("li a[href=?]", categories_path, :text => I18n.translate(:top))
  end

  it "should render the links to the ancestors" do
    render "/categories/show.html.erb"

    @ancestors.each do |ancestor|
      response.should have_tag("ul#ancestors li a[href=?]",
                               category_path(ancestor),
                               :text => ancestor.name)
    end
  end

  it "should render the links to the children" do
    render "/categories/show.html.erb"

    @children.each do |child|
      response.should have_tag("ul#children li a[href=?]",
                               category_path(child),
                               :text => child.name)
    end
  end

  it "should render the links to the lemmata" do
    render "/categories/show.html.erb"

    @lemmata.each do |lemma|
      response.should have_tag("ul#lemmata li a[href=?]",
                               lemma_path(lemma),
                               :text => /#{lemma.short1}.*#{lemma.short2}/)
    end
  end


  describe "for authorized users" do
    it_should_behave_like "an admin-authorized view"


    it "should have an edit link" do
      render "/categories/show.html.erb"
      response.should have_tag("a[href=?]",
                                          edit_category_path(@category),
                                          :text => I18n.translate(:edit))
    end

    it "should have a delete link" do
      render "/categories/show.html.erb"
      response.should have_tag("a[href=?][onclick]",
                                          category_path(@category),
                                          :text => I18n.translate(:delete))
    end

    it "should have a link to add another subcategory" do
      render "/categories/show.html.erb"
      response.should have_tag("a[href=?]",
                                          new_category_path(:category_id => @category.id),
                                          :text => I18n.translate(:add_category))
    end

    it "should have a link to add another lemma" do
      render "/categories/show.html.erb"
      response.should have_tag("a[href=?]",
                                          new_lemma_path(:category_id => @category.id),
                                          :text => I18n.translate(:add_lemma))
    end
  end
end

