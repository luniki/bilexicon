require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/new.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = stub_model(Lemma, :new_record? => true)
    assigns[:category] = @category = stub_model(Category, :name => "a category name")
  end

  it "should render form with short & long form, phonetics and classes" do
    render "/lemmata/new.html.erb"

    response.should have_tag("form[action=?][method=post]", category_lemmata_path(@category)) do
      %w(short long phonetic class).each do |name|
        (1..2).each { |i| with_tag("input#lemma_#{name}#{i}") }
      end
    end
  end

  it "should render form with short & long form, phonetics and classes" do
    render "/lemmata/new.html.erb"

    pending do
      (1..2).each { |i| response.should have_tag("form select#lemma_level#{i}") }
    end
  end
end

