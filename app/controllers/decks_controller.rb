class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def show
    @deck = current_user.decks.find(params[:id])
  end

  def new
    @deck = Deck.new
    @deck.name = Category.find(params[:category_id]).name if params[:category_id]
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = current_user.decks.build(params[:deck])
    if @deck.save
      flash[:notice] = 'Deck was successfully created.'
      redirect_to(@deck)
    else
      render :action => "new"
    end
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update_attributes(params[:deck])
      flash[:notice] = 'Deck was successfully updated.'
      redirect_to(@deck)
    else
      render :action => "edit"
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    redirect_to(decks_url(current_user))
  end
end
