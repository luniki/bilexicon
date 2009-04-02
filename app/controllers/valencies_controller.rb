class ValenciesController < ApplicationController

  before_filter :populate_lemma, :only => ["new", "create"]
  before_filter :require_admin

  def new
    @valency = Valency.new
    @valency.lemma = @lemma
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
      redirect_to(@valency.lemma)
    else
      render :action => "edit"
    end
  end

  def destroy
    @valency = Valency.find(params[:id])
    lemma = @valency.lemma
    @valency.destroy

    redirect_to(lemma)
  end
end
