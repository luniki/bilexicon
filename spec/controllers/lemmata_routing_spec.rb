require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LemmataController do
  describe "route generation" do

    it "should map #new" do
      route_for(:controller => "lemmata", :action => "new", :category_id => "37").should == "/lemmata/new?category_id=37"
    end

    it "should map #show" do
      route_for(:controller => "lemmata", :action => "show", :id => "1").should == "/lemmata/1"
    end

    it "should map #edit" do
      route_for(:controller => "lemmata", :action => "edit", :id => "1").should == "/lemmata/1/edit"
    end

    it "should map #update" do
      route_for(:controller => "lemmata", :action => "update", :id => "1").should == {:path => "/lemmata/1", :method => :put}
    end

    it "should map #destroy" do
      route_for(:controller => "lemmata", :action => "destroy", :id => "1").should == {:path => "/lemmata/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "should generate params for #new" do
      params_from(:get, "/lemmata/new").should == {:controller => "lemmata", :action => "new"}
    end

    it "should generate params for #create" do
      params_from(:post, "/lemmata").should == {:controller => "lemmata", :action => "create"}
    end

    it "should generate params for #show" do
      params_from(:get, "/lemmata/1").should == {:controller => "lemmata", :action => "show", :id => "1"}
    end

    it "should generate params for #edit" do
      params_from(:get, "/lemmata/1/edit").should == {:controller => "lemmata", :action => "edit", :id => "1"}
    end

    it "should generate params for #update" do
      params_from(:put, "/lemmata/1").should == {:controller => "lemmata", :action => "update", :id => "1"}
    end

    it "should generate params for #destroy" do
      params_from(:delete, "/lemmata/1").should == {:controller => "lemmata", :action => "destroy", :id => "1"}
    end
  end
end
