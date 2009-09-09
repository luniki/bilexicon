require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/edit.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = @lemma = stub_model(Lemma, :new_record? => false)
    assigns[:lemma_categories] = []
  end

  it "should render edit form with short & long form and phonetics" do
    render "/lemmata/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_path(@lemma)) do
      %w(short long phonetic).each do |name|
        (1..2).each { |i| with_tag("input#lemma_#{name}#{i}") }
      end
    end
  end

  it "should render edit form with a select for the word classes" do
    render "/lemmata/edit.html.erb"

    [1, 2].each do |side|
      response.should have_tag("select#lemma_word_class#{side}")
    end
  end

  it "should render edit form with a select for the level" do
    render "/lemmata/edit.html.erb"

    response.should have_tag("select#lemma_level_rezeptiv")
    response.should have_tag("select#lemma_level_produktiv")
  end

  it "should show the available categories" do

    assigns[:lemma_categories] = [stub_model(Category, :name => "automobiles"),
                                  stub_model(Category, :name => "vans")]
    render "/lemmata/edit.html.erb"

    response.should have_tag("select[name=?]", "lemma[category_ids][]")
  end

  it "should show a message if no categories exist" do
    render "/lemmata/edit.html.erb"

    response.should have_tag "span.lemma_categories", I18n.translate(:categories_missing)
  end

  it "should show a cancel link" do
    render "/lemmata/edit.html.erb"

    response.should have_tag("a[href=?]", lemma_path(@lemma))
  end
end

