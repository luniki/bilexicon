class ExamplesController < ApplicationController

#  def show
#    @example = Example.find(params[:id])
#  end

  def new
    @exampleable = Lemma.find(params[:lemma_id])
    @example = Example.new
  end

#  def edit
#    @example = Example.find(params[:id])
#  end

  def create
    @exampleable = Lemma.find(params[:lemma_id])

    @example = Example.new(params[:example])
    @example.exampleable = @exampleable

    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to(@exampleable)
    else
      render :action => "new"
    end



#    @category = Category.new(params[:category])

#    if @category.save
#      unless params[:category][:parent_id].blank?
#        parent = Category.find(params[:category][:parent_id])
#        @category.move_to_child_of parent if parent
#      end

#      flash[:notice] = t(:category_created)
#      redirect_to(@category)
#    else
#      flash.now[:notice] = t(:category_name_missing)
#      render :action => "new"
#    end

  end

#  def update
#    @example = Example.find(params[:id])
#    if @example.update_attributes(params[:example])
#      flash[:notice] = 'Example was successfully updated.'
#      redirect_to(@example)
#    else
#      render :action => "edit"
#    end
#  end

#  def destroy
#    @example = Example.find(params[:id])
#    @example.destroy

#    redirect_to(examples_url)
#  end
end
