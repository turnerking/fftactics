class CharactersController < ApplicationController
  before_filter :find_character
  
  def new
    @character = Character.new(:game_id => params[:game_id])
  end
  
  def create
    @character = Character.create_with_associations(params[:character])
    redirect_to game_path(Game.find(@character.game_id))
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    successful = @character.update_attributes(params[:character])
    render :json => successful
  end
  
  private
  
  def find_character
    @character = Character.find(params[:id]) if params[:id]
  end
end