require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExamplesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "examples", :action => "index").should == "/examples"
    end
  
    it "should map #new" do
      route_for(:controller => "examples", :action => "new").should == "/examples/new"
    end
  
    it "should map #show" do
      route_for(:controller => "examples", :action => "show", :id => 1).should == "/examples/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "examples", :action => "edit", :id => 1).should == "/examples/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "examples", :action => "update", :id => 1).should == "/examples/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "examples", :action => "destroy", :id => 1).should == "/examples/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/examples").should == {:controller => "examples", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/examples/new").should == {:controller => "examples", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/examples").should == {:controller => "examples", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/examples/1").should == {:controller => "examples", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/examples/1/edit").should == {:controller => "examples", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/examples/1").should == {:controller => "examples", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/examples/1").should == {:controller => "examples", :action => "destroy", :id => "1"}
    end
  end
end
