require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/show.html.erb" do
  include LemmataHelper

  before(:each) do
    assigns[:lemma] = @lemma = Factory(:verb)
    assigns[:categories] = @categories = @lemma.categories
    assigns[:examples] = @examples = [stub_model(Example, :form1 => 'a', :form2 => 'b')]
    assigns[:valencies] = @valencies = [stub_model(Valency, :form1 => 'a', :form2 => 'b', :synonym1 => "a", :synonym2 => "b")]
    assigns[:collocations] = @collocations = [stub_model(Collocation, :form1 => 'a', :form2 => 'b', :synonym1 => "a", :synonym2 => "b", :syntax1 => "a", :syntax2 => "b")]
    assigns[:phraseologisms] = @phraseologisms = [stub_model(Phraseologism, :form1 => 'a', :form2 => 'b', :synonym1 => "a", :synonym2 => "b")]
  end

  describe "the lemma" do

    it "should render both short forms" do
      render "/lemmata/show.html.erb"
      response.should have_tag "h1", /#{@lemma.short1}.+#{@lemma.short2}/
    end

    it "should render both long forms" do
      render "/lemmata/show.html.erb"
      response.should have_tag("div#?", "lemmata-#{@lemma.id}") do
        with_tag("div.form1", @lemma.long1)
        with_tag("div.form2", @lemma.long2)
      end
    end

    it "should render phonetics and word_class" do
      render "/lemmata/show.html.erb"
      response.should have_tag("div#?", "lemmata-#{@lemma.id}") do
        [1, 2].each do |side|
          with_tag("span.phonetic", /#{@lemma["phonetic#{side}"]}/)
          with_tag("span.word_class", /#{@lemma["word_class#{side}"]}/)
        end
        with_tag("span.level", /#{@lemma.level}/)
      end
    end

    it "should render the level" do
      render "/lemmata/show.html.erb"
      response.should have_tag("div#?", "lemmata-#{@lemma.id}") do
        with_tag("span.level", /#{@lemma.level}/)
      end
    end


    describe "and its examples" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.example")
      end
    end


    describe "and its valencies" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.valency")
      end

      it "should show the synonyms" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.valency span.synonym")
      end
    end


    describe "and its collocations" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.collocation")
      end

      it "should show the syntax" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.collocation span.syntax")
      end

      it "should show the synonyms" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.collocation span.synonym")
      end
    end


    describe "and its phraseologisms" do
      it "should render as a list" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.phraseologism")
      end

      it "should show the synonyms" do
        render "/lemmata/show.html.erb"
        response.should have_tag("li.phraseologism span.synonym")
      end
    end
  end

  describe "for authorized users" do
    it_should_behave_like "an admin-authorized view"

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
      response.should have_tag("div.entry-line a.cmd-editLemma")
    end

    it "should have a delete link" do
      render "/lemmata/show.html.erb"
      response.should have_tag("div.entry-line a.cmd-deleteEntry")
    end

    it "should have a link to add another example" do
      render "/lemmata/show.html.erb"
      response.should have_tag("div.entry-line a.cmd-addExample")
    end
  end
end

