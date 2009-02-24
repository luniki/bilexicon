require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/show.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = @lemma = stub_model(Lemma,
      :short1 => "wheel",    :short2 => "Rad",
      :phonetic1 => "ˈhwēl", :phonetic2 => "'það",
      :word_class => "V",    :level => "B1 R/P"
      )
    assigns[:categories] = @categories = [stub_model(Category, :name => "a name")]
    assigns[:examples] = @examples = [stub_model(Example, :form1 => 'a', :form2 => 'b')]
    assigns[:valencies] = @valencies = [stub_model(Valency, :form1 => 'a', :form2 => 'b', :synonym1 => "a", :synonym2 => "b")]
    assigns[:collocations] = @collocations = [stub_model(Collocation, :form1 => 'a', :form2 => 'b', :synonym1 => "a", :synonym2 => "b", :syntax1 => "a", :syntax2 => "b")]
    assigns[:phraseologisms] = @phraseologisms = [stub_model(Phraseologism, :form1 => 'a', :form2 => 'b', :synonym1 => "a", :synonym2 => "b")]
  end

  describe "the lemma" do

    it "should render both short forms" do
      render "/lemmata/show.html.erb"
      response.should have_tag("tr#? th", "lemma_#{@lemma.id}") do
        with_tag("th.short", @lemma.short1)
        with_tag("th.short", @lemma.short2)
      end
    end

    it "should render phonetics and word_class" do
      render "/lemmata/show.html.erb"
      response.should have_tag("tr#? th", "lemma_#{@lemma.id}") do
        with_tag("span.phonetic", /#{@lemma.phonetic1}/)
        with_tag("span.phonetic", /#{@lemma.phonetic2}/)
        with_tag("span.word_class", /#{@lemma.word_class}/)
        with_tag("span.level", /#{@lemma.level}/)
      end
    end

    it "should render the level" do
      render "/lemmata/show.html.erb"
      response.should have_tag("tr#? th", "lemma_#{@lemma.id}") do
        with_tag("span.level", /#{@lemma.level}/)
      end
    end


    describe "and its examples" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.example")
      end
    end


    describe "and its valencies" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.valency")
      end

      it "should show the synonyms" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.valency td span.synonym")
      end
    end


    describe "and its collocations" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.collocation")
      end

      it "should show the syntax" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.collocation td span.syntax")
      end

      it "should show the synonyms" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.collocation td span.synonym")
      end
    end


    describe "and its phraseologisms" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.phraseologism")
      end

      it "should show the synonyms" do
        render "/lemmata/show.html.erb"
        response.should have_tag("tr.phraseologism td span.synonym")
      end
    end
  end

  it "should have a link to the lemma's categories" do
    render "/lemmata/show.html.erb"
    @categories.each do |category|
      response.should have_tag("a[href=?]",
                                          category_path(category),
                                          :text => category.name)
    end
  end

  it "should have an edit link" do
    render "/lemmata/show.html.erb"
    response.should have_tag("a[href=?]",
                                        edit_lemma_path(@lemma),
                                        :text => I18n.translate(:edit))
  end

  it "should have a delete link" do
    render "/lemmata/show.html.erb"
    response.should have_tag("a[href=?][onclick]",
                                        lemma_path(@lemma),
                                        :text => I18n.translate(:delete))
  end

  it "should have a link to add another example" do
    render "/lemmata/show.html.erb"
    response.should have_tag("a[href=?]",
                                        new_lemma_example_path(@lemma),
                                        :text => I18n.translate(:add_example))
  end
end

