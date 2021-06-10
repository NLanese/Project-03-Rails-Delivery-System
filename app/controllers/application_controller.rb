class ApplicationController < ActionController::Base
    include ApplicationHelper

    def welcome
        clearErrorMessage(session)
        if is_logged_in?(session)
            redirect_to user_path(current_user(session))
        else
            session = []
        end
    end

    def login
        @message = assignMessage(session)
        @user = User.new
    end

    def end_session
        clearSession(session)
        redirect_to welcome_path
    end

    def fix_session
        session[:user_id] = nil
        redirect_to welcome_path
    end

end
