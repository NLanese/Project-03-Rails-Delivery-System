class SessionsController < ApplicationController
    include ApplicationHelper

    def create
        @user = User.find_by(name: sessions_params[:name])
        return head(:forbidden) unless @user.authenticate(sessions_params[:password])
        set_current_user(session, @user)
        session[:guest] = false
        if (@user.admin)
            session[:admin] = true
            #redirect_to admin_home_path
        else
            session[:admin] = false
            redirect_to user_deliveries_path(@user)
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