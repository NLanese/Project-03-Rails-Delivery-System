class GuestsController < ApplicationController
    include ApplicationHelper

    def create 
        session[:guest] = true
        session[:user_id] = nil
        redirect_to guest_delivery_path
    end

end