class CollocationsController < ApplicationController

  before_filter :populate_lemma, :only => ["new", "create", "sort"]
  before_filter :require_admin

  def new
    @collocation = Collocation.new
    @collocation.lemma = @lemma
  end

  def show
    @collocation = Collocation.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @collocation.lemma }
      format.json { render :json => @collocation.to_json(:methods => :meaning_list) }
    end
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

    respond_to do |format|
      if @collocation.update_attributes(params[:collocation])
        format.html {
                      flash[:notice] = 'Collocation was successfully updated.'
                      redirect_to @collocation.lemma
                    }
        format.js   { render :partial => "lemmata/collocation" }
      else
        format.html { render :action => "edit" }
        format.js   { render :nothing, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @collocation = Collocation.find(params[:id])
    lemma = @collocation.lemma
    @collocation.destroy

    redirect_to(lemma)
  end

  def sort
    params[:collocations].each_with_index do |id, index|
      Collocation.update_all(['position=?', index + 1],
                             ['id=? AND lemma_id=?', id, @lemma.id])
    end
    render :nothing => true
  end
end
