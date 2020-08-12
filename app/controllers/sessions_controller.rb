class SessionsController < ApplicationController

    def new 

    end

    def create 
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else
            redirect_to '/login', alert: "Invalid credentials. Please try again."
        end
    end

    def destroy 
        session.delete(:user_id)
        redirect_to '/login'
    end

    def omniauth
        user = User.from_omniauth(request.env['omniauth.auth'])
            if user.valid?
            session[:user_id] = user.id 
            redirect_to user_path(user)
            else
                redirect_to '/login'
            end
    
    end

    private 

    def auth 
        request.env['omniauth.auth']
    end
end
