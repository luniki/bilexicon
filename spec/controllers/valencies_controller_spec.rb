require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ValenciesController do

  it_should_behave_like "an admin-authorized controller"

  def mock_valency(stubs={})
    @mock_valency ||= mock_model(Valency, stubs)
  end

  before(:each) do
    @valencies = []
    @lemma = mock_model(Lemma, :save => true, :valencies => @valencies)
    Lemma.stub!(:find).with("37").and_return(@lemma)
  end

  describe "responding to GET new" do

    it "should set the valency's lemma" do
      Valency.stub!(:new).and_return(mock_valency)
      mock_valency.should_receive(:"lemma=")
      get :new, :lemma_id => "37"
      response.should be_success
    end

    it "should expose a new valency as @valency" do
      Valency.should_receive(:new).and_return(mock_valency(:"lemma=" => nil))
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:valency].should equal(mock_valency)
    end
  end

  describe "responding to GET edit" do

    it "should expose the requested valency as @valency" do
      Valency.should_receive(:find).with("37").and_return(mock_valency(:"lemma=" => nil))
      get :edit, :id => "37", :lemma_id => "37"
      assigns[:valency].should equal(mock_valency)
    end
  end


  describe "responding to POST create" do

    before(:each) do
      @param_valency = {
        "form1" => "s.o. drives s.o.",
        "form2" => "j-m fährt jemanden",
        "syntax1" => "N(P) + V + N(P)",
        "syntax2" => "N(P) + V + N(P)",
        "meaning_list" => "fast, car"
      }
    end

    it "should save the meanings of the valency" do
      post :create, :valency => @param_valency, :lemma_id => "37"
      assigns(:valency).meanings.should_not be_empty
    end

    describe "with valid params" do

      before(:each) do
        @valency = mock_valency(:save => true)
        Valency.should_receive(:new).with(@param_valency).and_return(@valency)
      end

      it "should expose a newly created valency as @valency" do
        post :create, :valency => @param_valency, :lemma_id => "37"
        assigns(:valency).should equal(@valency)
      end

      it "should add the newly created valency to the lemma's valencies" do
        @valencies.should_receive(:"<<").with(@valency)
        post :create, :valency => @param_valency, :lemma_id => "37"
      end

      it "should redirect to the lemma of the valency" do
        post :create, :valency => @param_valency, :lemma_id => "37"
        response.should redirect_to(lemma_url(@lemma))
      end

    end

    describe "with invalid params" do

      before(:each) do
        @valency = mock_valency(:save => false)
        Valency.should_receive(:new).and_return(@valency)
      end

      it "should expose a newly created but unsaved valency as @valency" do
        post :create, :valency => {}, :lemma_id => "37"
        assigns(:valency).should equal(@valency)
      end

      it "should re-render the 'new' template" do
        post :create, :valency => {}, :lemma_id => "37"
        response.should render_template('new')
      end
    end
  end


  describe "responding to PUT udpate" do

    before(:each) do
      @param_valency = {
          "form1" => "s.o. drives s.o.",
          "form2" => "j-m fährt jemanden",
          "syntax1" => "N(P) + V + N(P)",
          "syntax2" => "N(P) + V + N(P)",
      }
    end

    describe "with valid params" do

      it "should update the requested valency" do
        Valency.should_receive(:find).with("37").and_return(mock_valency)
        mock_valency.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :valency => {:these => 'params'}, :lemma_id => "37"
      end

      it "should expose the requested valency as @valency" do
        Valency.stub!(:find).and_return(mock_valency(:update_attributes => true, :lemma => @lemma))
        put :update, :id => "1", :lemma_id => "37"
        assigns(:valency).should equal(mock_valency)
      end

      it "should redirect to the valency" do
        Valency.stub!(:find).and_return(mock_valency(:update_attributes => true, :lemma => @lemma))
        put :update, :id => "1", :lemma_id => "37"
        response.should redirect_to(lemma_url(@lemma))
      end
    end

    describe "with invalid params" do

      it "should update the requested valency" do
        Valency.should_receive(:find).with("37").and_return(mock_valency(:lemma => @lemma))
        mock_valency.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :valency => {:these => 'params'}, :lemma_id => "37"
      end

      it "should expose the valency as @valency" do
        Valency.stub!(:find).and_return(mock_valency(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37"
        assigns(:valency).should equal(mock_valency)
      end

      it "should re-render the 'edit' template" do
        Valency.stub!(:find).and_return(mock_valency(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37"
        response.should render_template('edit')
      end
    end
  end


  describe "responding to DELETE destroy" do

    it "should destroy the requested valency" do
      Valency.should_receive(:find).with("37").and_return(mock_valency(:lemma => @lemma))
      mock_valency.should_receive(:destroy)
      delete :destroy, :id => "37", :lemma_id => "37"
    end

    it "should redirect to the valencies list" do
      Valency.stub!(:find).and_return(mock_valency(:destroy => true, :lemma => @lemma))
      delete :destroy, :id => "1", :lemma_id => "37"
      response.should redirect_to(lemma_url(@lemma))
    end
  end

end
