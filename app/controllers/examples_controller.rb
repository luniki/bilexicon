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
    @example = Example.new(params[:example])
    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to(@example)
    else
      render :action => "new"
    end
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
