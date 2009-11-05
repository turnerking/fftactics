class GamesController < ApplicationController

  def show
    @game = Game.first
  end

end