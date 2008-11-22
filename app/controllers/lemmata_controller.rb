class LemmataController < ApplicationController

  before_filter :capture_category

  def index
    @lemmata = Lemma.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lemmata }
    end
  end

  def show
    @lemma = Lemma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lemma }
    end
  end

  def new
    @lemma = Lemma.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lemma }
    end
  end

  def edit
    @lemma = Lemma.find(params[:id])
  end

  def create
    @lemma = @category.lemmata.build(params[:lemma])

    respond_to do |format|
      if @lemma.save
        flash[:notice] = 'Lemma was successfully created.'
        format.html { redirect_to([@category, @lemma]) }
        format.xml  { render :xml => @lemma, :status => :created, :location => @lemma }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lemma.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @lemma = Lemma.find(params[:id])

    respond_to do |format|
      if @lemma.update_attributes(params[:lemma])
        flash[:notice] = 'Lemma was successfully updated.'
        format.html { redirect_to(@lemma) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lemma.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @lemma = Lemma.find(params[:id])
    @lemma.destroy

    respond_to do |format|
      format.html { redirect_to(@category) }
      format.xml  { head :ok }
    end
  end

  private

  def capture_category
    @category = Category.find(params[:category_id]) if params[:category_id]
    @lemma = @category.lemmata.find(params[:id]) if params[:id]
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def not_found
    flash[:notice] = "Das gesuchte Lemma konnte nicht gefunden werden."
    redirect_to categories_path
  end
end
