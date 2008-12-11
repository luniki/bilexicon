require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExamplesController do

  def mock_example(stubs={})
    @mock_example ||= mock_model(Example, stubs)
  end

#  describe "responding to GET index" do

#    it "should expose all examples as @examples" do
#      Example.should_receive(:find).with(:all).and_return([mock_example])
#      get :index
#      assigns[:examples].should == [mock_example]
#    end

#  end

#  describe "responding to GET show" do

#    it "should expose the requested example as @example" do
#      Example.should_receive(:find).with("37").and_return(mock_example)
#      get :show, :id => "37"
#      assigns[:example].should equal(mock_example)
#    end
#
#  end

  describe "responding to GET new" do

    it "should expose a the example's lemma as @exampleable" do
      lemma = mock_model(Lemma)
      Lemma.stub!(:find).with("37").and_return(lemma)
      Example.stub!(:new)
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:exampleable].should equal(lemma)
    end

    it "should expose a new example as @example" do
      Lemma.stub!(:find).with("37")
      Example.should_receive(:new).and_return(mock_example)
      get :new, :lemma_id => "37"
      response.should be_success
      assigns[:example].should equal(mock_example)
    end

  end

#  describe "responding to GET edit" do
#
#    it "should expose the requested example as @example" do
#      Example.should_receive(:find).with("37").and_return(mock_example)
#      get :edit, :id => "37"
#      assigns[:example].should equal(mock_example)
#    end

#  end

#  describe "responding to POST create" do

#    describe "with valid params" do
#
#      it "should expose a newly created example as @example" do
#        Example.should_receive(:new).with({'these' => 'params'}).and_return(mock_example(:save => true))
#        post :create, :example => {:these => 'params'}
#        assigns(:example).should equal(mock_example)
#      end

#      it "should redirect to the created example" do
#        Example.stub!(:new).and_return(mock_example(:save => true))
#        post :create, :example => {}
#        response.should redirect_to(example_url(mock_example))
#      end
#
#    end
#
#    describe "with invalid params" do

#      it "should expose a newly created but unsaved example as @example" do
#        Example.stub!(:new).with({'these' => 'params'}).and_return(mock_example(:save => false))
#        post :create, :example => {:these => 'params'}
#        assigns(:example).should equal(mock_example)
#      end

#      it "should re-render the 'new' template" do
#        Example.stub!(:new).and_return(mock_example(:save => false))
#        post :create, :example => {}
#        response.should render_template('new')
#      end
#
#    end
#
#  end

#  describe "responding to PUT udpate" do

#    describe "with valid params" do

#      it "should update the requested example" do
#        Example.should_receive(:find).with("37").and_return(mock_example)
#        mock_example.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :example => {:these => 'params'}
#      end

#      it "should expose the requested example as @example" do
#        Example.stub!(:find).and_return(mock_example(:update_attributes => true))
#        put :update, :id => "1"
#        assigns(:example).should equal(mock_example)
#      end

#      it "should redirect to the example" do
#        Example.stub!(:find).and_return(mock_example(:update_attributes => true))
#        put :update, :id => "1"
#        response.should redirect_to(example_url(mock_example))
#      end

#    end
#
#    describe "with invalid params" do

#      it "should update the requested example" do
#        Example.should_receive(:find).with("37").and_return(mock_example)
#        mock_example.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :example => {:these => 'params'}
#      end

#      it "should expose the example as @example" do
#        Example.stub!(:find).and_return(mock_example(:update_attributes => false))
#        put :update, :id => "1"
#        assigns(:example).should equal(mock_example)
#      end

#      it "should re-render the 'edit' template" do
#        Example.stub!(:find).and_return(mock_example(:update_attributes => false))
#        put :update, :id => "1"
#        response.should render_template('edit')
#      end

#    end

#  end

#  describe "responding to DELETE destroy" do

#    it "should destroy the requested example" do
#      Example.should_receive(:find).with("37").and_return(mock_example)
#      mock_example.should_receive(:destroy)
#      delete :destroy, :id => "37"
#    end
#
#    it "should redirect to the examples list" do
#      Example.stub!(:find).and_return(mock_example(:destroy => true))
#      delete :destroy, :id => "1"
#      response.should redirect_to(examples_url)
#    end

#  end

end
