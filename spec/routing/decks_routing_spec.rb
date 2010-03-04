require 'spec_helper'

describe DecksController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/decks" }.should route_to(:controller => "decks", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/decks/new" }.should route_to(:controller => "decks", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/decks/1" }.should route_to(:controller => "decks", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/decks/1/edit" }.should route_to(:controller => "decks", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/decks" }.should route_to(:controller => "decks", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/decks/1" }.should route_to(:controller => "decks", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/decks/1" }.should route_to(:controller => "decks", :action => "destroy", :id => "1") 
    end
  end
end
