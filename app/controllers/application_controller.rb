class ApplicationController < ActionController::Base
    include ApplicationHelper

    def welcome
        if is_logged_in?(session)
            redirect_to user_deliveries_path(current_user(session))
        else
            session = []
        end
    end

    def login
        @user = User.new
    end

end
