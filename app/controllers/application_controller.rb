class ApplicationController < ActionController::Base

    def welcome
    end

    def login
        @user = User.new
    end

end
