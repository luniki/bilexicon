class ExamplesController < ApplicationController

  before_filter :require_admin


  def new
    @example = Example.new
    @example.exampleable = context_object
  end

  def show
    @example = Example.find(params[:id])
    respond_to do |format|
      format.html { redirect_to_exampleable @example.exampleable }
      format.json { render :json => @example }
    end
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

    respond_to do |format|
      if @example.update_attributes(params[:example])
        format.html {
                      flash[:notice] = 'Example was successfully updated.'
                      redirect_to_exampleable
                    }
        format.js   { render :partial => "lemmata/example" }
      else
        format.html { render :action => "edit" }
        format.js   { render :nothing, :status => :unprocessable_entity }
      end
    end

  end

  def destroy
    @example = Example.find(params[:id])
    exampleable = @example.exampleable
    @example.destroy

    redirect_to_exampleable exampleable
  end

  def sort
    params[:sequence].each_with_index do |id, index|
      Example.update_all(['position=?', index + 1],
                         ['id=? AND exampleable_id=?', id, context_id])
    end
    render :nothing => true
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
