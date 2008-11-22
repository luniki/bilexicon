class CategoriesController < ApplicationController

  def index
    @categories = Category.find_all_by_parent_id(nil)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @categories }
    end
  end

  def show
    @category = Category.find(params[:id])
    @children = @category.children
    @lemmata  = @category.lemmata

    respond_to do |format|
      format.html
      format.xml  { render :xml => @category }
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.save!

    unless params[:category][:parent_id].blank?
      parent = Category.find(params[:category][:parent_id])
      @category.move_to_child_of parent if parent
    end

    respond_to do |format|
      flash[:notice] = t(:category_created)
      format.html { redirect_to(@category) }
      format.xml  { render :xml => @category, :status => :created, :location => @category }
    end

  rescue Exception => err
    # TODO (mlunzena) what to do with the exception
    respond_to do |format|
      format.html { render :action => "new" }
      format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes!(params[:category])

    if params[:category].key? :parent_id
      if params[:category][:parent_id].blank?
        @category.move_to_root
      else parent = Category.find(params[:category][:parent_id])
        @category.move_to_child_of parent if parent
      end
    end

    respond_to do |format|
      flash[:notice] = t(:category_edited)
      format.html { redirect_to(@category) }
      format.xml  { head :ok }
    end

  rescue
    # TODO (mlunzena) what to do with the exception
    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
