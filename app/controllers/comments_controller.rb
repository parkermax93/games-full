class CommentsController < ApplicationController
    before_action :find_comment, only: [:show, :edit, :update, :destroy]
    before_action :redirect_if_not_user, only: [:edit, :update, :destroy]

    def index
    @comments = Comment.org
        if params[:games_id]
            @comments = Game.find(params[:game_id]).comments
        else
            @comments = Comment.all
        end
    end

    def new 
        @game = Game.find(params[:game_id])
        @comment = @game.comments.build
    end

    def create 
    @game = Game.find(params[:game_id])
    @comment = @game.comments.build(comment_params)
    @comment.user_id = current_user.id 
        if @comment.save 
            redirect_to game_path(@game)
        else
            redirect_to new_game_comment_path(@game)
        end
    end

    def show 
        find_comment
    end

    def edit 
        find_comment
    end

    def update 
        @game = Game.find(params[:game_id])
        find_comment
        if @comment.user == current_user 
            @comment.update(comment_params)
            redirect_to game_path(@game)
        else
            render :edit 
        end
    end

    def destroy 
        @game.comment.destroy 
        redirect_to games_path
    end 

    private 

    def comment_params 
        params.require(:comment).permit(:body, :game_id, user_attributes: [:username])
    end

    def redirect_if_not_user 
        if @comment.user != current_user 
            redirect_to user_path(current_user), alert: "You Do Not Have Permission To Edit This Comment!"
        end
    end

    def find_comment 
        @comment = Comment.find(params[:id])
    end
end