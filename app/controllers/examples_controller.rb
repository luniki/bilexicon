class ExamplesController < ApplicationController

  def context_object(*finder_options)
    params[:context_type].classify.constantize.find(context_id, *finder_options)
  end

  def context_id
    params["#{params[:context_type]}_id"]
  end

  def new
    @exampleable = context_object
    @example = Example.new
  end

  def edit
    @example = Example.find(params[:id])
  end

  def create

    @exampleable = context_object
    @example = Example.new(params[:example])
    @example.exampleable = @exampleable

    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to(@exampleable)
    else
      render :action => "new"
    end

  end

  def update
    @exampleable = context_object
    @example = Example.find(params[:id])
    if @example.update_attributes(params[:example])
      flash[:notice] = 'Example was successfully updated.'
      redirect_to(@exampleable)
    else
      render :action => "edit"
    end
  end

  def destroy
    @exampleable = context_object
    @example = Example.find(params[:id])
    @example.destroy

    redirect_to(@exampleable)
  end
end
