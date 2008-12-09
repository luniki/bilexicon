require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/show.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = @lemma = stub_model(Lemma,
      :short1 => "wheel",    :short2 => "Rad",
      :phonetic1 => "ˈhwēl", :phonetic2 => "'það",
      :class1 => "V",   :class2 => "V",
      :level1 => "B1 R/P",   :level2 => "B1 R/P"
      )
    assigns[:category] = @category = stub_model(Category, :name => "a name")
  end

  describe "the lemma" do

    it "should render both short forms" do
      render "/lemmata/show.html.erb"
      response.should have_tag("tr#? th", "lemma_#{@lemma.id}") do
        with_tag("th.short", @lemma.short1)
        with_tag("th.short", @lemma.short2)
      end
    end

    it "should render phonetics, classes and levels" do
      render "/lemmata/show.html.erb"
      response.should have_tag("tr#? th", "lemma_#{@lemma.id}") do
        with_tag("span.phonetic", /#{@lemma.phonetic1}/)
        with_tag("span.phonetic", /#{@lemma.phonetic2}/)
        with_tag("span.class", /#{@lemma.class1}/)
        with_tag("span.class", /#{@lemma.class2}/)
      end
    end

  end

  describe "and the sidebar" do

    before(:each) do
      render "/lemmata/show.html.erb"
    end

    it "should have a link to the parent category" do

      response[:sidebar].should have_tag("a[href=?]",
                                         category_path(@category),
                                         :text => @category.name)
    end

    it "should have an edit link" do
      response[:sidebar].should have_tag("a[href=?]",
                                         edit_lemma_path(@lemma),
                                         :text => I18n.translate(:edit))
    end

    it "should have a delete link" do
      response[:sidebar].should have_tag("a[href=?][onclick]",
                                         lemma_path(@lemma),
                                         :text => I18n.translate(:delete))
    end

  end
end

