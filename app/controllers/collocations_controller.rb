class CollocationsController < ApplicationController

  before_filter :populate_lemma
  before_filter :require_user

  def new
    @collocation = Collocation.new
  end

  def edit
    @collocation = Collocation.find(params[:id])
  end

  def create
    @collocation = Collocation.new(params[:collocation])
    @lemma.collocations << @collocation

    if @collocation.save
      flash[:notice] = 'Collocation was successfully created.'
      redirect_to(@lemma)
    else
      render :action => "new"
    end
  end

  def update
    @collocation = Collocation.find(params[:id])
    if @collocation.update_attributes(params[:collocation])
      flash[:notice] = 'Collocation was successfully updated.'
      redirect_to(@lemma)
    else
      render :action => "edit"
    end
  end

  def destroy
    @collocation = Collocation.find(params[:id])
    @collocation.destroy

    redirect_to(@lemma)
  end
end
