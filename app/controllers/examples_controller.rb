class ExamplesController < ApplicationController

  before_filter :require_admin


  def new
    @example = Example.new
    @example.exampleable = context_object
  end

  def edit
    @example = Example.find(params[:id])
  end

  def create

    @example = Example.new(params[:example])
    @example.exampleable = context_object

    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to_exampleable
    else
      render :action => "new"
    end

  end

  def update
    @example = Example.find(params[:id])
    if @example.update_attributes(params[:example])
      flash[:notice] = 'Example was successfully updated.'
      redirect_to_exampleable
    else
      render :action => "edit"
    end
  end

  def destroy
    @example = Example.find(params[:id])
    exampleable = @example.exampleable
    @example.destroy

    redirect_to_exampleable exampleable
  end

  private
    def context_object(*finder_options)
      params[:context_type].classify.constantize.find(context_id, *finder_options)
    end

    def context_id
      params["#{params[:context_type]}_id"]
    end

    def redirect_to_exampleable(exampleable = nil)
      exampleable ||= context_object
      redirect_to(exampleable.is_a?(Lemma) ? exampleable : exampleable.lemma)
    end
end
