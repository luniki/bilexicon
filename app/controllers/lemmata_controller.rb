class LemmataController < ApplicationController

  before_filter :require_admin, :except => [:index, :show]

  def index
    if params[:q].present?
      @lemmata = Lemma.search params[:q], :page => (params[:page] || 1)
    end
  end

  def show
    @lemma = Lemma.find(params[:id])
    @categories = @lemma.categories
    @examples = @lemma.examples
    @valencies = @lemma.valencies
    @collocations = @lemma.collocations
    @phraseologisms = @lemma.phraseologisms
  end

  def new
    @lemma = Lemma.new
    @lemma.categories << Category.find(params[:category_id]) if params[:category_id]
    @categories = Category.find(:all)
  end

  def edit
    @lemma = Lemma.find(params[:id])
    @categories = Category.find(:all)

    respond_to do |format|
      format.html
      format.js { render :partial => "ajax_edit" }
      format.pdf { render :layout => false }
    end
  end

  def create
    @lemma = Lemma.new(params[:lemma])
    @categories = Category.find(:all)
    if @lemma.save
      flash[:notice] = 'Lemma was successfully created.'
      redirect_to(@lemma)
    else
      render :action => "new"
    end
  end

  def update
    @lemma = Lemma.find(params[:id])

    respond_to do |format|
      if @lemma.update_attributes(params[:lemma])
        format.html {
                      flash[:notice] = 'Lemma was successfully updated.'
                      redirect_to @lemma
                    }
        format.js   { render :partial => "lemma" }
      else
        format.html { render :action => "edit" }
        # TODO
        format.js   { render :partial => "ajax_edit",
                             :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @lemma = Lemma.find(params[:id])
    @lemma.destroy

    redirect_to(lemmata_path)
  end

end
