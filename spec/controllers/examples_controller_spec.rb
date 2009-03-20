require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExamplesController do

  it_should_behave_like "an admin-authorized controller"

  def mock_example(stubs={})
    @mock_example ||= mock_model(Example, stubs)
  end

  before(:each) do
    @lemma = mock_model(Lemma, :save => true)
    Lemma.stub!(:find).with("37").and_return(@lemma)
  end

  describe "responding to GET new" do

    it "should expose a the example's lemma as @exampleable" do
      Example.stub!(:new)
      get :new, :lemma_id => "37", :context_type => "lemma"
      response.should be_success
      assigns[:exampleable].should equal(@lemma)
    end

    it "should expose a new example as @example" do
      Example.should_receive(:new).and_return(mock_example)
      get :new, :lemma_id => "37", :context_type => "lemma"
      response.should be_success
      assigns[:example].should equal(mock_example)
    end

  end

  describe "responding to GET edit" do

    it "should expose the requested example as @example" do
      Example.should_receive(:find).with("37").and_return(mock_example)
      get :edit, :id => "37", :lemma_id => "37", :context_type => "lemma"
      assigns[:example].should equal(mock_example)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do

      before(:each) do
        @example = mock_example(:save => true)
      end

      it "should expose a newly created example as @example" do
        param_example = {
                         "form1" => "To be or not to be.",
                         "form2" => "Sein oder nicht sein.",
                         "syntax1" => "X + Y + Z",
                         "syntax2" => "X + Y + Z",
                         "synonym1" => "a synonym",
                         "synonym2" => "ein Synonym",
                        }
        Example.should_receive(:new).with(param_example).and_return(@example)
        @example.should_receive(:'exampleable=')
        post :create, :example => param_example,
                      :lemma_id => "37",
                      :context_type => "lemma"
        assigns(:example).should equal(@example)
      end

      it "should redirect to the lemma of the example" do
        param_example = {
                         "form1" => "To be or not to be.",
                         "form2" => "Sein oder nicht sein.",
                         "syntax1" => "X + Y + Z",
                         "syntax1" => "X + Y + Z",
                         "synonym1" => "a synonym",
                         "synonym2" => "ein Synonym",
                        }
        Example.should_receive(:new).with(param_example).and_return(@example)
        @example.should_receive(:'exampleable=')
        post :create, :example => param_example,
                      :lemma_id => "37",
                      :context_type => "lemma"
        response.should redirect_to(lemma_url(@lemma))
      end

    end

    describe "with invalid params" do

      before(:each) do
        @example = mock_example(:save => false, :'exampleable=' => nil)
        Example.should_receive(:new).and_return(@example)
      end

      it "should expose a newly created but unsaved example as @example" do
        post :create, :example => {}, :lemma_id => "37", :context_type => "lemma"
        assigns(:example).should equal(@example)
      end

      it "should re-render the 'new' template" do
        post :create, :example => {}, :lemma_id => "37", :context_type => "lemma"
        response.should render_template('new')
      end
    end
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested example" do
        Example.should_receive(:find).with("37").and_return(mock_example)
        mock_example.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :example => {:these => 'params'}, :lemma_id => "37", :context_type => "lemma"
      end

      it "should expose the requested example as @example" do
        Example.stub!(:find).and_return(mock_example(:update_attributes => true))
        put :update, :id => "1", :lemma_id => "37", :context_type => "lemma"
        assigns(:example).should equal(mock_example)
      end

      it "should redirect to the example" do
        Example.stub!(:find).and_return(mock_example(:update_attributes => true))
        put :update, :id => "1", :lemma_id => "37", :context_type => "lemma"
        response.should redirect_to(lemma_url(@lemma))
      end
    end

    describe "with invalid params" do

      it "should update the requested example" do
        Example.should_receive(:find).with("37").and_return(mock_example)
        mock_example.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :example => {:these => 'params'}, :lemma_id => "37", :context_type => "lemma"
      end

      it "should expose the example as @example" do
        Example.stub!(:find).and_return(mock_example(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37", :context_type => "lemma"
        assigns(:example).should equal(mock_example)
      end

      it "should re-render the 'edit' template" do
        Example.stub!(:find).and_return(mock_example(:update_attributes => false))
        put :update, :id => "1", :lemma_id => "37", :context_type => "lemma"
        response.should render_template('edit')
      end
    end
  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested example" do
      Example.should_receive(:find).with("37").and_return(mock_example)
      mock_example.should_receive(:destroy)
      delete :destroy, :id => "37", :lemma_id => "37", :context_type => "lemma"
    end

    it "should redirect to the examples list" do
      Example.stub!(:find).and_return(mock_example(:destroy => true))
      delete :destroy, :id => "1", :lemma_id => "37", :context_type => "lemma"
      response.should redirect_to(lemma_url(@lemma))
    end
  end
end
