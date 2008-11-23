class CategoriesController < ApplicationController

  def index
    @categories = Category.find_all_by_parent_id(nil)
  end

  def show
    @category = Category.find(params[:id])
    @children = @category.children
    @lemmata  = @category.lemmata
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

    flash[:notice] = t(:category_created)
    redirect_to(@category)

  rescue Exception => err
    # TODO (mlunzena) what to do with the exception
    flash[:notice] = err
    render :action => "new"
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

    flash[:notice] = t(:category_edited)
    redirect_to(@category)

  rescue
    # TODO (mlunzena) what to do with the exception
    flash[:notice] = err
    render :action => "edit"
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to(categories_url)
  end
end
