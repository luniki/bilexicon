class CollocationsController < ApplicationController

  before_filter :populate_lemma, :only => ["new", "create"]
  before_filter :require_admin

  def new
    @collocation = Collocation.new
    @collocation.lemma = @lemma
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
      redirect_to(@collocation.lemma)
    else
      render :action => "edit"
    end
  end

  def destroy
    @collocation = Collocation.find(params[:id])
    lemma = @collocation.lemma
    @collocation.destroy

    redirect_to(lemma)
  end
end
