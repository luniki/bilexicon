require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/lemmata/index.html.erb" do
  include LemmataHelper

  it "should render an empty search form" do
    render "/lemmata/index.html.erb"
    response.should have_tag("form[action=?]", lemmata_path) do
      with_tag("input[name=q]")
    end
  end


  describe "after searching without success" do
    before(:each) do
      assigns[:lemmata] = []
      params[:q] = "a word that cannot be found"
    end

    it "should render failure message" do
      render "/lemmata/index.html.erb"

      response.should have_tag("p", "0 #{I18n.translate(:search_results_for)} \"a word that cannot be found\"")
    end
  end

  describe "after successfully searching" do
    before(:each) do
      assigns[:lemmata] = [
        stub_model(Lemma, :short1 => "to be", :short2 => "sein"),
        stub_model(Lemma, :short1 => "or",    :short2 => "oder"),
      ]
      params[:q] = "a result"
    end

    it "should render the number of matches" do
      render "/lemmata/index.html.erb"

      response.should have_tag("p", "#{assigns[:lemmata].size} #{I18n.translate(:search_results_for)} \"a result\"")
    end

    it "should render a list of matching" do
      render "/lemmata/index.html.erb"

      response.should have_tag("ul#lemmata") do
        with_tag("li.lemma", :count => assigns[:lemmata].size) do
          assigns[:lemmata].each do |lemma|
            with_tag("a[href=?]", lemma_path(lemma), :text => "#{lemma.short1} · #{lemma.short2}")
          end
        end
      end

    end
  end
end

