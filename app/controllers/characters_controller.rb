class CharactersController < ApplicationController
  def new
    @character = Character.new(:game_id => params[:game_id])
  end
  
  def create
    @character = Character.create_with_associations(params[:character])
    redirect_to character_path(@character)
  end
  
  def show
    @character = Character.find(params[:id])
    redirect_to game_path(@character.game_id)
  end
  
  def update
  end
end