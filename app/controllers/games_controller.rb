class GamesController < ApplicationController
    before_action :find_game, :redirect_if_not_user, only: [:show, :edit, :update, :destroy]

    def index
        @games = Game.all 
    end

    def new 
        @game = Game.new
    end

    def create 
        @game = current_user.games.build(game_params)
        if @game.valid?
            @game.save
            redirect_to game_path(@game)
        else 
            @game = Game.find_by_id(params[:game_id]) if params[:game_id]
            render :new 
        end
    end

    def edit 
        find_game
    end

    def update 
        find_game
        if @game.user == current_user 
            @game.update(game_params)
            redirect_to game_path(@game)
        else
            render :edit 
        end
    end

    def show 

    end

    def destroy 
        @game.destroy 
        redirect_to game_path 
    end

    private 

    def game_params 
        params.require(:game).permid(:name, :developer, :release_year, :description, :genre_id)
    end

    def redirect_if_not_user 
        if @game.user != current_user 
            redirect_to user_path(current_user), alert: "You Do Not Have Permission To Edit This Game!"
        end
    end

    def find_game 
        @game = Game.find(params[:id])
    end
end