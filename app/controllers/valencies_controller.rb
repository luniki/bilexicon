class ValenciesController < ApplicationController

  before_filter :populate_lemma, :only => ["new", "create", "sort"]
  before_filter :require_admin

  def new
    @valency = Valency.new
    @valency.lemma = @lemma
  end

  def show
    @valency = Valency.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @valency.lemma }
      format.json { render :json => @valency.to_json(:methods => :meaning_list) }
    end
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

    respond_to do |format|
      if @valency.update_attributes(params[:valency])
        format.html {
                      flash[:notice] = 'Valency was successfully updated.'
                      redirect_to @valency.lemma
                    }
        format.js   { render :partial => "lemmata/valency" }
      else
        format.html { render :action => "edit" }
        format.js   { render :nothing, :status => :unprocessable_entity }
      end
    end

  end

  def destroy
    @valency = Valency.find(params[:id])
    lemma = @valency.lemma
    @valency.destroy

    redirect_to(lemma)
  end

  def sort
    params[:valencies].each_with_index do |id, index|
      Valency.update_all(['position=?', index + 1],
                         ['id=? AND lemma_id=?', id, @lemma.id])
    end
    render :nothing => true
  end
end
