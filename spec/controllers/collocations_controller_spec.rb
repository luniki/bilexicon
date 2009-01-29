require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CollocationsController do

  def mock_collocation(stubs={})
    @mock_collocation ||= mock_model(Collocation, stubs)
  end

  before(:each) do
    @collocations = []
    @lemma = mock_model(Lemma, :save => true, :collocations => @collocations)
    Lemma.stub!(:find).with("37").and_return(@lemma)
  end

  describe "responding to GET new" do

    it "should expose a the collocation's lemma as @lemma" do
      Collocation.stub!(:new)
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:lemma].should equal(@lemma)
    end

    it "should expose a new collocation as @collocation" do
      Collocation.should_receive(:new).and_return(mock_collocation)
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:collocation].should equal(mock_collocation)
    end
  end

  describe "responding to GET edit" do

    it "should expose the requested collocation as @collocation" do
      Collocation.should_receive(:find).with("37").and_return(mock_collocation)
      get :edit, :id => "37", :lemma_id => "37"
      assigns[:collocation].should equal(mock_collocation)
    end
  end


  describe "responding to POST create" do

    describe "with valid params" do

      before(:each) do
        @param_collocation = {
          "form1" => "s.o./a car drives fast",
          "form2" => "j-m/ein Wagen fährt schnell",
          "syntax1" => "V + ADV",
          "syntax2" => "V + ADV"
        }
        @collocation = mock_collocation(:save => true)
        Collocation.should_receive(:new).with(@param_collocation).and_return(@collocation)
      end

      it "should expose a newly created collocation as @collocation" do
        post :create, :collocation => @param_collocation, :lemma_id => "37"
        assigns(:collocation).should equal(@collocation)
      end

      it "should add the newly created collocation to the lemma's collocations" do
        @collocations.should_receive(:"<<").with(@collocation)
        post :create, :collocation => @param_collocation, :lemma_id => "37"
      end

      it "should redirect to the lemma of the collocation" do
        post :create, :collocation => @param_collocation, :lemma_id => "37"
        response.should redirect_to(lemma_url(@lemma))
      end

    end

    describe "with invalid params" do

      before(:each) do
        @collocation = mock_collocation(:save => false)
        Collocation.should_receive(:new).and_return(@collocation)
      end

      it "should expose a newly created but unsaved collocation as @collocation" do
        post :create, :collocation => {}, :lemma_id => "37"
        assigns(:collocation).should equal(@collocation)
      end

      it "should re-render the 'new' template" do
        post :create, :collocation => {}, :lemma_id => "37"
        response.should render_template('new')
      end
    end
  end


  describe "responding to PUT udpate" do

    before(:each) do
      @param_collocation = {
        "form1" => "s.o./a car drives fast",
        "form2" => "j-m/ein Wagen fährt schnell",
        "syntax1" => "V + ADV",
        "syntax2" => "V + ADV"
      }
    end

    describe "with valid params" do

      it "should update the requested collocation" do
        Collocation.should_receive(:find).with("37").and_return(mock_collocation)
        mock_collocation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :collocation => {:these => 'params'}, :lemma_id => "37"
      end

      it "should expose the requested collocation as @collocation" do
        Collocation.stub!(:find).and_return(mock_collocation(:update_attributes => true))
        put :update, :id => "1", :lemma_id => "37"
        assigns(:collocation).should equal(mock_collocation)
      end

      it "should redirect to the collocation" do
        Collocation.stub!(:find).and_return(mock_collocation(:update_attributes => true))
        put :update, :id => "1", :lemma_id => "37"
        response.should redirect_to(lemma_url(@lemma))
      end
    end

    describe "with invalid params" do

      it "should update the requested collocation" do
        Collocation.should_receive(:find).with("37").and_return(mock_collocation)
        mock_collocation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :collocation => {:these => 'params'}, :lemma_id => "37"
      end

      it "should expose the collocation as @collocation" do
        Collocation.stub!(:find).and_return(mock_collocation(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37"
        assigns(:collocation).should equal(mock_collocation)
      end

      it "should re-render the 'edit' template" do
        Collocation.stub!(:find).and_return(mock_collocation(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37"
        response.should render_template('edit')
      end
    end
  end


  describe "responding to DELETE destroy" do

    it "should destroy the requested collocation" do
      Collocation.should_receive(:find).with("37").and_return(mock_collocation)
      mock_collocation.should_receive(:destroy)
      delete :destroy, :id => "37", :lemma_id => "37"
    end

    it "should redirect to the collocations list" do
      Collocation.stub!(:find).and_return(mock_collocation(:destroy => true))
      delete :destroy, :id => "1", :lemma_id => "37"
      response.should redirect_to(lemma_url(@lemma))
    end
  end
end
