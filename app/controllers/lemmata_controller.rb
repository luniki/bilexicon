class LemmataController < ApplicationController
  # GET /lemmata
  # GET /lemmata.xml
  def index
    @lemmata = Lemma.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lemmata }
    end
  end

  # GET /lemmata/1
  # GET /lemmata/1.xml
  def show
    @lemma = Lemma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lemma }
    end
  end

  # GET /lemmata/new
  # GET /lemmata/new.xml
  def new
    @lemma = Lemma.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lemma }
    end
  end

  # GET /lemmata/1/edit
  def edit
    @lemma = Lemma.find(params[:id])
  end

  # POST /lemmata
  # POST /lemmata.xml
  def create
    @lemma = Lemma.new(params[:lemma])

    respond_to do |format|
      if @lemma.save
        flash[:notice] = 'Lemma was successfully created.'
        format.html { redirect_to(@lemma) }
        format.xml  { render :xml => @lemma, :status => :created, :location => @lemma }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lemma.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lemmata/1
  # PUT /lemmata/1.xml
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

  # DELETE /lemmata/1
  # DELETE /lemmata/1.xml
  def destroy
    @lemma = Lemma.find(params[:id])
    @lemma.destroy

    respond_to do |format|
      format.html { redirect_to(lemmata_url) }
      format.xml  { head :ok }
    end
  end
end
