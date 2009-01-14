require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/new.html.erb" do
  include LemmataHelper

  before(:each) do
    @categories =
      [stub_model(Category, :name => "a category name"),
       stub_model(Category, :name => "another category name")]

    assigns[:categories] = @categories
    assigns[:lemma] = @lemma = stub_model(Lemma, :new_record? => true,
                                          :categories => [@categories[0]])
  end

  it "should render form with short & long form, phonetics and classes" do
    render "/lemmata/new.html.erb"

    response.should have_tag("form[action=?][method=post]", lemmata_path) do
      %w(short long phonetic class).each do |name|
        (1..2).each { |i| with_tag("input#lemma_#{name}#{i}") }
      end
    end
  end

  it "should render form with level" do
    render "/lemmata/new.html.erb"

    pending do
      (1..2).each { |i| response.should have_tag("form select#lemma_level#{i}") }
    end
  end

  it "should show the available  categories" do
    template.should_receive(:nested_set_options).and_return(@categories.collect {|i| [i.name, i.id]} )
    render "/lemmata/new.html.erb"

    response.should have_tag("form select#categories") do
      @categories.each do |c|
        if @lemma.categories.include?(c) then
          with_tag("option[selected][value=?]", c.id, :text => c.name)
        else
          with_tag("option[value=?]:not([selected])", c.id, :text => c.name)
        end
      end
    end
  end

  it "should show a cancel link" do
    render "/lemmata/new.html.erb"

    response.should have_tag("a[href=?]", lemmata_path)
  end
end

