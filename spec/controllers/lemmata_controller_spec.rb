require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LemmataController do

  def mock_lemma(stubs={})
    @mock_lemma ||= mock_model(Lemma, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all lemmatas as @lemmatas" do
      Lemma.should_receive(:find).with(:all).and_return([mock_lemma])
      get :index
      assigns[:lemmata].should == [mock_lemma]
    end

    describe "with mime type of xml" do
  
      it "should render all lemmatas as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Lemma.should_receive(:find).with(:all).and_return(lemmata = mock("Array of Lemmata"))
        lemmata.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested lemma as @lemma" do
      Lemma.should_receive(:find).with("37").and_return(mock_lemma)
      get :show, :id => "37"
      assigns[:lemma].should equal(mock_lemma)
    end
    
    describe "with mime type of xml" do

      it "should render the requested lemma as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Lemma.should_receive(:find).with("37").and_return(mock_lemma)
        mock_lemma.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new lemma as @lemma" do
      Lemma.should_receive(:new).and_return(mock_lemma)
      get :new
      assigns[:lemma].should equal(mock_lemma)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested lemma as @lemma" do
      Lemma.should_receive(:find).with("37").and_return(mock_lemma)
      get :edit, :id => "37"
      assigns[:lemma].should equal(mock_lemma)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created lemma as @lemma" do
        Lemma.should_receive(:new).with({'these' => 'params'}).and_return(mock_lemma(:save => true))
        post :create, :lemma => {:these => 'params'}
        assigns(:lemma).should equal(mock_lemma)
      end

      it "should redirect to the created lemma" do
        Lemma.stub!(:new).and_return(mock_lemma(:save => true))
        post :create, :lemma => {}
        response.should redirect_to(lemma_url(mock_lemma))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved lemma as @lemma" do
        Lemma.stub!(:new).with({'these' => 'params'}).and_return(mock_lemma(:save => false))
        post :create, :lemma => {:these => 'params'}
        assigns(:lemma).should equal(mock_lemma)
      end

      it "should re-render the 'new' template" do
        Lemma.stub!(:new).and_return(mock_lemma(:save => false))
        post :create, :lemma => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested lemma" do
        Lemma.should_receive(:find).with("37").and_return(mock_lemma)
        mock_lemma.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :lemma => {:these => 'params'}
      end

      it "should expose the requested lemma as @lemma" do
        Lemma.stub!(:find).and_return(mock_lemma(:update_attributes => true))
        put :update, :id => "1"
        assigns(:lemma).should equal(mock_lemma)
      end

      it "should redirect to the lemma" do
        Lemma.stub!(:find).and_return(mock_lemma(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(lemma_url(mock_lemma))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested lemma" do
        Lemma.should_receive(:find).with("37").and_return(mock_lemma)
        mock_lemma.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :lemma => {:these => 'params'}
      end

      it "should expose the lemma as @lemma" do
        Lemma.stub!(:find).and_return(mock_lemma(:update_attributes => false))
        put :update, :id => "1"
        assigns(:lemma).should equal(mock_lemma)
      end

      it "should re-render the 'edit' template" do
        Lemma.stub!(:find).and_return(mock_lemma(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested lemma" do
      Lemma.should_receive(:find).with("37").and_return(mock_lemma)
      mock_lemma.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the lemmata list" do
      Lemma.stub!(:find).and_return(mock_lemma(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(lemmata_url)
    end

  end

end
