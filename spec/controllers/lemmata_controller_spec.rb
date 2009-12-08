require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LemmataController do

  def mock_lemma(stubs={})
    @mock_lemma ||= mock_model(Lemma, stubs)
  end

  describe "responding to GET index" do

    it_should_behave_like "an authenticated controller"

    it "should expose @lemmata after searching" do
      Lemma.should_receive(:search).with("a search word", anything()).and_return([mock_lemma])
      get :index, :q => "a search word"
      assigns[:lemmata].should == [mock_lemma]
    end
  end

  describe "responding to GET show" do

    it_should_behave_like "an authenticated controller"

    before (:each) do
      @categories = [mock_model(Category)]
      @examples = [mock_model(Example)]
      @valencies = [mock_model(Valency)]
      @collocations = [mock_model(Collocation)]
      @phraseologisms = [mock_model(Phraseologism)]
      @lemma = mock_lemma(:categories     => @categories,
                          :examples       => @examples,
                          :collocations   => @collocations,
                          :phraseologisms => @phraseologisms,
                          :valencies      => @valencies)
      Lemma.should_receive(:find).with("37").and_return(@lemma)
    end

    it "should expose the requested lemma as @lemma" do
      get :show, :id => "37"
      assigns[:lemma].should equal(@lemma)
    end

    it "should expose the requested lemma's categories as @categories" do
      get :show, :id => "37"
      assigns[:categories].should equal(@categories)
    end

    it "should expose the requested lemma's examples as @examples" do
      get :show, :id => "37"
      assigns[:examples].should equal(@examples)
    end
  end

  describe "with a valid user session" do

    it_should_behave_like "an admin-authorized controller"


    describe "responding to GET new" do

      it "should expose a new lemma as @lemma" do
        Lemma.should_receive(:new).and_return(mock_lemma(:categories => []))
        get :new
        response.should be_success
        assigns[:lemma].should equal(mock_lemma)
      end
    end

    describe "responding to GET edit" do

      it "should expose the requested lemma as @lemma" do
        Lemma.should_receive(:find).with("37").and_return(mock_lemma(:categories => []))
        get :edit, :id => "37"
        assigns[:lemma].should equal(mock_lemma)
      end
    end

    describe "responding to POST create" do

      before (:each) do
        @categories = [mock_model(Category), mock_model(Category)]
        @lemma = mock_lemma(:categories => [], :examples => [])
        Lemma.should_receive(:new).and_return(@lemma)
      end

      describe "with valid params" do

        before (:each) do
          @lemma.stub!(:save).and_return(true)
        end

        it "should expose a newly created lemma as @lemma" do
          post :create, :lemma => {}
          assigns(:lemma).should equal(@lemma)
        end

        it "should redirect to the created lemma" do
          post :create, :lemma => {}
          response.should redirect_to(lemma_url(@lemma))
        end

      end

      describe "with invalid params" do

        before(:each) do
          @lemma.stub!(:save).and_return(false)
        end

        it "should expose a newly created but unsaved lemma as @lemma" do
          post :create, :lemma => {}
          assigns(:lemma).should equal(@lemma)
        end

        it "should re-render the 'new' template" do
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
        Lemma.should_receive(:find).with("37").and_return(mock_lemma())
        mock_lemma.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "should redirect to the lemmata's index" do
        Lemma.stub!(:find).with("1").and_return(mock_lemma(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(lemmata_path)
      end

    end

  end

end
