class LemmataController < ApplicationController

  def index
    @lemmata = Lemma.search(params[:q]) unless params[:q].blank?
  end

  def show
    @lemma = Lemma.find(params[:id])
    @examples = @lemma.examples
    @categories = @lemma.categories
  end

  def new
    @lemma = Lemma.new
    @lemma.categories << Category.find(params[:category_id]) if params[:category_id]
    @categories = Category.find(:all)
    @lemma_categories = @lemma.categories
  end

  def edit
    @lemma = Lemma.find(params[:id])
    @categories = Category.find(:all)
    @lemma_categories = @lemma.categories
  end

  def create
    @lemma = Lemma.new(params[:lemma])
    if @lemma.save
      flash[:notice] = 'Lemma was successfully created.'
      redirect_to(@lemma)
    else
      render :action => "new"
    end
  end

  def update
    @lemma = Lemma.find(params[:id])

    if @lemma.update_attributes(params[:lemma])
      flash[:notice] = 'Lemma was successfully updated.'
      redirect_to(@lemma)
    else
      render :action => "edit"
    end
  end

  def destroy
    @lemma = Lemma.find(params[:id])
    @lemma.destroy

    redirect_to(lemmata_path)
  end

end
