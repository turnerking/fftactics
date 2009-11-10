class GamesController < ApplicationController
  
  def index
    @games = Game.all || []
  end

  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @main_character = Character.new(:name => "Ramza", :gender => "Male", :main_character => true)
  end

  def create
    main_character = Character.create_with_associations(params[:character])
    @game = Game.create!
    @game.characters << main_character
    redirect_to game_path(@game)
  end

end