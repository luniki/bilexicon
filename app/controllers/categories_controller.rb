class CategoriesController < ApplicationController

  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      if params[:category][:parent_id]
        parent = Category.find(params[:category][:parent_id])
        @category.move_to_child_of parent if parent
      end

      flash[:notice] = t(:category_created)
      redirect_to(@category)
    else
      flash.now[:notice] = t(:category_name_missing)
      render :action => "new"
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])

      if params[:category] and params[:category][:parent_id]
        if params[:category][:parent_id].blank?
          @category.move_to_root
        else parent = Category.find(params[:category][:parent_id])
          @category.move_to_child_of parent if parent
        end
      end

      flash[:notice] = t(:category_edited)
      redirect_to(@category)

    else

      render :action => "edit"

    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to(categories_url)
  end
end
