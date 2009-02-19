class ValenciesController < ApplicationController
  before_filter :populate_lemma

  def new
    @valency = Valency.new
  end


  def edit
    @valency = Valency.find(params[:id])
  end

  def create
    @valency = Valency.new(params[:valency])
    @lemma.valencies << @valency

    if @valency.save
      flash[:notice] = 'Valency was successfully created.'
      redirect_to(@lemma)
    else
      render :action => "new"
    end
  end

  def update
    @valency = Valency.find(params[:id])
    if @valency.update_attributes(params[:valency])
      flash[:notice] = 'Valency was successfully updated.'
      redirect_to(@lemma)
    else
      render :action => "edit"
    end
  end

  def destroy
    @valency = Valency.find(params[:id])
    @valency.destroy

    redirect_to(@lemma)
  end
end
