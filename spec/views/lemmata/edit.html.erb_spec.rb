require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/edit.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = @lemma = stub_model(Lemma, :new_record? => false)
  end

  it "should render edit form with short & long form, phonetics and classes" do
    render "/lemmata/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_path(@lemma)) do
      %w(short long phonetic class).each do |name|
        (1..2).each { |i| with_tag("input#lemma_#{name}#{i}") }
      end
    end
  end

  it "should render edit form with a select for the level" do
    render "/lemmata/edit.html.erb"

    pending do
      (1..2).each { |i| response.should have_tag("select#lemma_level#{i}") }
    end
  end

  it "should show the available  categories" do
    render "/lemmata/new.html.erb"
    pending
  end

  it "should show a cancel link" do
    render "/lemmata/edit.html.erb"

    response.should have_tag("a[href=?]", lemma_path(@lemma))
  end
end

