require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhraseologismsController do

  it_should_behave_like "an admin-authorized controller"

  def mock_phraseologism(stubs={})
    @mock_phraseologism ||= mock_model(Phraseologism, stubs)
  end

  before(:each) do
    @phraseologisms = []
    @lemma = mock_model(Lemma, :save => true, :phraseologisms => @phraseologisms)
    Lemma.stub!(:find).with("37").and_return(@lemma)
  end

  describe "responding to GET new" do

    it "should expose a the phraseologism's lemma as @lemma" do
      Phraseologism.stub!(:new).and_return(mock_phraseologism(:"lemma=" => nil))
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:lemma].should equal(@lemma)
    end

    it "should expose a new phraseologism as @phraseologism" do
      Phraseologism.should_receive(:new).and_return(mock_phraseologism(:"lemma=" => nil))
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:phraseologism].should equal(mock_phraseologism)
    end
  end

  describe "responding to GET edit" do

    it "should expose the requested phraseologism as @phraseologism" do
      Phraseologism.should_receive(:find).with("37").and_return(mock_phraseologism(:lemma => @lemma))
      get :edit, :id => "37", :lemma_id => "37"
      assigns[:phraseologism].should equal(mock_phraseologism)
    end
  end


  describe "responding to POST create" do

    describe "with valid params" do

      before(:each) do
        @param_phraseologism = {
          "form1" => "a car bound to somewhere",
          "form2" => "ein Auto, das irgendwo hinfährt"
        }
        @phraseologism = mock_phraseologism(:save => true)
        Phraseologism.should_receive(:new).with(@param_phraseologism).and_return(@phraseologism)
      end

      it "should expose a newly created phraseologism as @phraseologism" do
        post :create, :phraseologism => @param_phraseologism, :lemma_id => "37"
        assigns(:phraseologism).should equal(@phraseologism)
      end

      it "should add the newly created phraseologism to the lemma's phraseologisms" do
        @phraseologisms.should_receive(:"<<").with(@phraseologism)
        post :create, :phraseologism => @param_phraseologism, :lemma_id => "37"
      end

      it "should redirect to the lemma of the phraseologism" do
        post :create, :phraseologism => @param_phraseologism, :lemma_id => "37"
        response.should redirect_to(lemma_url(@lemma))
      end

    end

    describe "with invalid params" do

      before(:each) do
        @phraseologism = mock_phraseologism(:save => false)
        Phraseologism.should_receive(:new).and_return(@phraseologism)
      end

      it "should expose a newly created but unsaved phraseologism as @phraseologism" do
        post :create, :phraseologism => {}, :lemma_id => "37"
        assigns(:phraseologism).should equal(@phraseologism)
      end

      it "should re-render the 'new' template" do
        post :create, :phraseologism => {}, :lemma_id => "37"
        response.should render_template('new')
      end
    end
  end


  describe "responding to PUT udpate" do

    before(:each) do
      @param_phraseologism = {
          "form1" => "a car bound to somewhere",
          "form2" => "ein Auto, das irgendwo hinfährt"
      }
    end

    describe "with valid params" do

      it "should update the requested phraseologism" do
        Phraseologism.should_receive(:find).with("37").and_return(mock_phraseologism)
        mock_phraseologism.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :phraseologism => {:these => 'params'}, :lemma_id => "37"
      end

      it "should expose the requested phraseologism as @phraseologism" do
        Phraseologism.stub!(:find).and_return(mock_phraseologism(:update_attributes => true, :lemma => @lemma))
        put :update, :id => "1", :lemma_id => "37"
        assigns(:phraseologism).should equal(mock_phraseologism)
      end

      it "should redirect to the phraseologism" do
        Phraseologism.stub!(:find).and_return(mock_phraseologism(:update_attributes => true, :lemma => @lemma))
        put :update, :id => "1", :lemma_id => "37"
        response.should redirect_to(lemma_url(@lemma))
      end
    end

    describe "with invalid params" do

      it "should update the requested phraseologism" do
        Phraseologism.should_receive(:find).with("37").and_return(mock_phraseologism)
        mock_phraseologism.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :phraseologism => {:these => 'params'}, :lemma_id => "37"
      end

      it "should expose the phraseologism as @phraseologism" do
        Phraseologism.stub!(:find).and_return(mock_phraseologism(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37"
        assigns(:phraseologism).should equal(mock_phraseologism)
      end

      it "should re-render the 'edit' template" do
        Phraseologism.stub!(:find).and_return(mock_phraseologism(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37"
        response.should render_template('edit')
      end
    end
  end


  describe "responding to DELETE destroy" do

    it "should destroy the requested phraseologism" do
      Phraseologism.should_receive(:find).with("37").and_return(mock_phraseologism(:lemma => @lemma))
      mock_phraseologism.should_receive(:destroy)
      delete :destroy, :id => "37", :lemma_id => "37"
    end

    it "should redirect to the phraseologisms list" do
      Phraseologism.stub!(:find).and_return(mock_phraseologism(:destroy => true, :lemma => @lemma))
      delete :destroy, :id => "1", :lemma_id => "37"
      response.should redirect_to(lemma_url(@lemma))
    end
  end

end
