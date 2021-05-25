class SessionsController < ApplicationController
    include ApplicationHelper

    def create
        @user = User.find_by(name: sessions_params[:name])
        if @user.authenticate(sessions_params[:password])
            clearErrorMessage(session)
            set_current_user(session, @user)
            session[:guest] = false
            session[:admin] = false
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            clearErrorMessage(session)
            addErrorMessage(session, "Incorrect password")
            redirect_to login_path
        end
    end

    def destroy
        clear_user(session)
        #binding.pry
        redirect_to root_path
    end

    private
    
        def sessions_params
            params.require(:user).permit(:name, :password)
        end
    
    end