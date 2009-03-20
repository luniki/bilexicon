require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExamplesController do
  describe "route generation" do

    it "should map #new" do
      route_for(:controller => "examples",
                :action => "new",
                :lemma_id => "37",
                :context_type=>"lemma").should == "/lemmata/37/examples/new"
    end

    it "should map #edit" do
      route_for(:controller => "examples",
                :action => "edit",
                :id => "1",
                :lemma_id => "37",
                :context_type=>"lemma").should == "/lemmata/37/examples/1/edit"
    end

    it "should map #update" do
      route_for(:controller => "examples",
                :action => "update",
                :id => "1",
                :lemma_id => "37",
                :context_type=>"lemma").should == {:path => "/lemmata/37/examples/1", :method => :put}
    end

    it "should map #destroy" do
      route_for(:controller => "examples",
                :action => "destroy",
                :id => "1",
                :lemma_id => "37",
                :context_type=>"lemma").should == {:path => "/lemmata/37/examples/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params for #new" do
      params_from(:get, "/lemmata/37/examples/new").should ==
        {
          :controller => "examples",
          :action => "new",
          :lemma_id => "37",
          :context_type=>"lemma"
        }
    end

    it "should generate params for #create" do
      params_from(:post, "/lemmata/37/examples").should ==
        {
          :controller => "examples",
          :action => "create",
          :lemma_id => "37",
          :context_type=>"lemma"
        }
    end

    it "should generate params for #edit" do
      params_from(:get, "/lemmata/37/examples/1/edit").should ==
        {
          :controller => "examples",
          :action => "edit",
          :id => "1",
          :lemma_id => "37",
          :context_type=>"lemma"
        }
    end

    it "should generate params for #update" do
      params_from(:put, "/lemmata/37/examples/1").should ==
        {
          :controller => "examples",
          :action => "update",
          :id => "1",
          :lemma_id => "37",
          :context_type=>"lemma"
        }
    end

    it "should generate params for #destroy" do
      params_from(:delete, "/lemmata/37/examples/1").should ==
        {
          :controller => "examples",
          :action => "destroy",
          :id => "1",
          :lemma_id => "37",
          :context_type=>"lemma"
        }
    end
  end
end
