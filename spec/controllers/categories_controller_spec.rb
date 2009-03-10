require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Category, stubs)
  end

  describe "responding to GET index" do

    it "should expose all top categories as @categories" do
      Category.should_receive(:roots).and_return([mock_category])
      get :index
      assigns[:categories].should == [mock_category]
    end

  end

  describe "responding to GET show" do

    before (:each) do
      @ancestors = [mock_model(Category)]
      @children = [mock_model(Category)]
      @lemmata = [mock_model(Lemma), mock_model(Lemma)]
      @category = mock_category(:ancestors => @ancestors,
                                :children => @children,
                                :lemmata => @lemmata)
      Category.should_receive(:find).with("37").and_return(@category)
    end

    it "should expose the requested category as @category" do
      get :show, :id => "37"
      assigns[:category].should equal(@category)
    end

    it "should expose the requested category's ancestors as @ancestors" do
      get :show, :id => "37"
      assigns[:ancestors].should equal(@ancestors)
    end

    it "should expose the requested category's children as @children" do
      get :show, :id => "37"
      assigns[:children].should equal(@children)
    end

    it "should expose the requested category's lemmata as @lemmata" do
      get :show, :id => "37"
      assigns[:lemmata].should equal(@lemmata)
    end

  end

  describe "with a valid user session" do

    it_should_behave_like "an admin-authorized controller"

    describe "responding to GET new" do


      it "should expose a new category as @category" do
        Category.should_receive(:new).and_return(mock_category)
        get :new
        assigns[:category].should equal(mock_category)
      end

    end

    describe "responding to GET edit" do

      it "should expose the requested category as @category" do
        Category.should_receive(:find).with("37").and_return(mock_category)
        get :edit, :id => "37"
        assigns[:category].should equal(mock_category)
      end

    end

    describe "responding to POST create" do

      describe "with valid params" do

        it "should expose a newly created category as @category" do
          Category.should_receive(:new).with({'name' => 'valid name'}).and_return(mock_category(:save => true))
          post :create, :category => {:name => 'valid name'}
          assigns(:category).should equal(mock_category)
        end

        it "should show a flash notice" do
          post :create, :category => {:name => 'valid name'}
          flash[:notice].should == I18n.translate(:category_created)
        end

        it "should redirect to the created category" do
          Category.stub!(:new).and_return(mock_category(:save => true))
          post :create, :category => {:name => 'valid name'}
          response.should redirect_to(category_url(mock_category))
        end


      end

      describe "with invalid params" do

        it "should expose a newly created but unsaved category as @category" do
          Category.stub!(:new).with({'these' => 'params'}).and_return(mock_category(:save => false))
          post :create, :category => {:these => 'params'}
          assigns(:category).should equal(mock_category)
        end

        it "should re-render the 'new' template" do
          Category.stub!(:new).and_return(mock_category(:save => false))
          post :create, :category => {}
          response.should render_template('new')
        end

      end


      describe "with a parent ID" do

        it "should insert the created category as a child of that parent" do
          new_category = mock_model(Category, {:save => true})
          Category.should_receive(:new).and_return(new_category)
          Category.stub!(:find).with("23").and_return(mock_category)
          new_category.should_receive(:move_to_child_of).with(mock_category)
          post :create, :category => {:parent_id => "23"}
        end
      end

      describe "without a parent ID" do
        it "should move the created category to the top" do
          Category.should_receive(:new).and_return(mock_category(:save => true))
          Category.should_not_receive(:move_to_child_of)
          post :create, :category => {}
        end
      end

    end

    describe "responding to PUT udpate" do

      describe "with valid params" do

        it "should update the requested category" do
          Category.should_receive(:find).with("37").and_return(mock_category)
          mock_category.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :category => {:these => 'params'}
        end

        it "should expose the requested category as @category" do
          Category.stub!(:find).and_return(mock_category(:update_attributes => true))
          put :update, :id => "1", :category => {:name => 'a name'}
          assigns(:category).should equal(mock_category)
        end

        it "should redirect to the category" do
          Category.stub!(:find).and_return(mock_category(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(category_url(mock_category))
        end

        describe "and with a parent ID" do
          it "should move the requested category to its new parent" do
            parent = mock_model(Category)
            Category.stub!(:find).with("37").and_return(mock_category(:update_attributes => true))
            Category.stub!(:find).with("42").and_return(parent)
            mock_category.should_receive(:move_to_child_of).with(parent)
            put :update, :id => "37", :category => {:parent_id => "42"}
          end
        end

        describe "and with a blank parent ID" do
          it "should move the requested category to the root" do
            Category.stub!(:find).with("37").and_return(mock_category(:update_attributes => true))
            mock_category.should_receive(:move_to_root)
            put :update, :id => "37", :category => {:parent_id => ""}
          end
        end

      end

      describe "with invalid params" do

        it "should update the requested category" do
          Category.should_receive(:find).with("37").and_return(mock_category)
          mock_category.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :category => {:these => 'params'}
        end

        it "should expose the category as @category" do
          Category.stub!(:find).and_return(mock_category(:update_attributes => false))
          put :update, :id => "1"
          assigns(:category).should equal(mock_category)
        end

        it "should re-render the 'edit' template" do
          Category.stub!(:find).and_return(mock_category(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end

      end

    end

    describe "responding to DELETE destroy" do

      it "should destroy the requested category" do
        Category.should_receive(:find).with("37").and_return(mock_category)
        mock_category.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "should redirect to the categories list" do
        Category.stub!(:find).and_return(mock_category(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(categories_url)
      end

    end

  end

end
