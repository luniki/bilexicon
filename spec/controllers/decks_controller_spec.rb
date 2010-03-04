require 'spec_helper'

describe DecksController do

  def mock_deck(stubs={})
    @mock_deck ||= mock_model(Deck, stubs)
  end

  describe "GET index" do
    it "assigns all decks as @decks" do
      Deck.stub(:find).with(:all).and_return([mock_deck])
      get :index
      assigns[:decks].should == [mock_deck]
    end
  end

  describe "GET show" do
    it "assigns the requested deck as @deck" do
      Deck.stub(:find).with("37").and_return(mock_deck)
      get :show, :id => "37"
      assigns[:deck].should equal(mock_deck)
    end
  end

  describe "GET new" do
    it "assigns a new deck as @deck" do
      Deck.stub(:new).and_return(mock_deck)
      get :new
      assigns[:deck].should equal(mock_deck)
    end
  end

  describe "GET edit" do
    it "assigns the requested deck as @deck" do
      Deck.stub(:find).with("37").and_return(mock_deck)
      get :edit, :id => "37"
      assigns[:deck].should equal(mock_deck)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created deck as @deck" do
        Deck.stub(:new).with({'these' => 'params'}).and_return(mock_deck(:save => true))
        post :create, :deck => {:these => 'params'}
        assigns[:deck].should equal(mock_deck)
      end

      it "redirects to the created deck" do
        Deck.stub(:new).and_return(mock_deck(:save => true))
        post :create, :deck => {}
        response.should redirect_to(deck_url(mock_deck))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deck as @deck" do
        Deck.stub(:new).with({'these' => 'params'}).and_return(mock_deck(:save => false))
        post :create, :deck => {:these => 'params'}
        assigns[:deck].should equal(mock_deck)
      end

      it "re-renders the 'new' template" do
        Deck.stub(:new).and_return(mock_deck(:save => false))
        post :create, :deck => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested deck" do
        Deck.should_receive(:find).with("37").and_return(mock_deck)
        mock_deck.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :deck => {:these => 'params'}
      end

      it "assigns the requested deck as @deck" do
        Deck.stub(:find).and_return(mock_deck(:update_attributes => true))
        put :update, :id => "1"
        assigns[:deck].should equal(mock_deck)
      end

      it "redirects to the deck" do
        Deck.stub(:find).and_return(mock_deck(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(deck_url(mock_deck))
      end
    end

    describe "with invalid params" do
      it "updates the requested deck" do
        Deck.should_receive(:find).with("37").and_return(mock_deck)
        mock_deck.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :deck => {:these => 'params'}
      end

      it "assigns the deck as @deck" do
        Deck.stub(:find).and_return(mock_deck(:update_attributes => false))
        put :update, :id => "1"
        assigns[:deck].should equal(mock_deck)
      end

      it "re-renders the 'edit' template" do
        Deck.stub(:find).and_return(mock_deck(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested deck" do
      Deck.should_receive(:find).with("37").and_return(mock_deck)
      mock_deck.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the decks list" do
      Deck.stub(:find).and_return(mock_deck(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(decks_url)
    end
  end

end
