class SessionsController < ApplicationController
    include ApplicationHelper
    include SessionHelper

    def create
        @user = User.find_by(name: sessions_params[:name])
        if (@user == nil)
            addErrorMessage(session, "User does not exist!")
            redirect_to signup_path
        elsif @user.authenticate(sessions_params[:password])
            set_up_login(session, @user)
            redirect_to user_path(@user)
        else
            clearErrorMessage(session)
            addErrorMessage(session, "Incorrect password")
            redirect_to login_path
        end
    end

    def oauth
        data = request.env['omniauth.auth']
        email = data[:info][:email]
        name = data[:info][:name]
        uid = data[:uid]
        if (User.find_by(uid: uid) != nil )
            @user = User.find_by(uid: uid)
            set_up_login(session, @user)
            redirect_to user_path(@user)
        else
            @user = User.create(name: name, email: email, uid: uid, password_digest: data[:credentials][:token], credit: 0)
            clearErrorMessage(session)
            set_up_login(session, @user)
            redirect_to user_path(@user)
        end
    end

    def destroy
        clear_user(session)
        redirect_to root_path
    end

    private
    
        def sessions_params
            params.require(:user).permit(:name, :password, :email, :uid)
        end
    
    end