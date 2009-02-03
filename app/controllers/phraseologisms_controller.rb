class PhraseologismsController < ApplicationController
  before_filter :populate_lemma

  def new
    @phraseologism = Phraseologism.new
  end

  def edit
    @phraseologism = Phraseologism.find(params[:id])
  end

  def create
    @phraseologism = Phraseologism.new(params[:phraseologism])
    @lemma.phraseologisms << @phraseologism

    if @phraseologism.save
      flash[:notice] = 'Phraseologism was successfully created.'
      redirect_to(@lemma)
    else
      render :action => "new"
    end
  end

  def update
    @phraseologism = Phraseologism.find(params[:id])
    if @phraseologism.update_attributes(params[:phraseologism])
      flash[:notice] = 'Phraseologism was successfully updated.'
      redirect_to(@lemma)
    else
      render :action => "edit"
    end
  end

  def destroy
    @phraseologism = Phraseologism.find(params[:id])
    @phraseologism.destroy

    redirect_to(@lemma)
  end
end
