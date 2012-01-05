class PhraseologismsController < ApplicationController

  before_filter :populate_lemma, :only => ["new", "create", "sort"]
  before_filter :require_admin

  def new
    @phraseologism = Phraseologism.new
    @phraseologism.lemma = @lemma
  end

  def show
    @phraseologism = Phraseologism.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @phraseologism.lemma }
      format.json { render :json => @phraseologism.to_json(:methods => :meaning_list) }
    end
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

    respond_to do |format|
      if @phraseologism.update_attributes(params[:phraseologism])
        format.html {
                      flash[:notice] = 'Phraseologism was successfully updated.'
                      redirect_to @phraseologism.lemma
                    }
        format.js   { render :partial => "lemmata/phraseologism" }
      else
        format.html { render :action => "edit" }
        format.js   {
                      render :json => @phraseologism.errors,
                             :status => :unprocessable_entity
                    }
      end
    end
  end

  def destroy
    @phraseologism = Phraseologism.find(params[:id])
    lemma = @phraseologism.lemma
    @phraseologism.destroy

    respond_to do |format|
      format.js   { head 200 }
      format.html { redirect_to(lemma) }
    end

  end

  def sort
    params[:sequence].each_with_index do |id, index|
      Phraseologism.update_all(['position=?', index + 1],
                               ['id=? AND lemma_id=?', id, @lemma.id])
    end
    render :nothing => true
  end
end
