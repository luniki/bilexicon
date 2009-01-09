class LemmataController < ApplicationController

  before_filter :capture_category, :only => [:create, :new]

  def index
    @lemmata = Lemma.search(params[:q]) unless params[:q].blank?
  end

  def show
    @lemma = Lemma.find(params[:id])
    @category = @lemma.category
  end

  def new
    @lemma = Lemma.new
  end

  def edit
    @lemma = Lemma.find(params[:id])
  end

  def create
    @lemma = @category.lemmata.build(params[:lemma])
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
    @category = @lemma.category
    @lemma.destroy

    redirect_to(@category)
  end


  private

  def capture_category
    @category = Category.find(params[:category_id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def not_found
    flash[:notice] = "Das gesuchte Lemma konnte nicht gefunden werden."
    redirect_to categories_path
  end
end
