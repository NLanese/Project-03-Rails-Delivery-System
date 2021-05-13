class DeliveriesController < ApplicationController
    include ApplicationHelper
    skip_before_action :verify_authenticity_token, :only => [:payment_options]

    def index
        if (has_errors?(session))  # If Error
            @message = errorMsg(session)  # Make error
        else
            @message = ""
        end
        if is_logged_in?(session)        # Checks if user is logged in
            if (current_user(session) == get_user_delivery.id)  #  Makes sure you are looking at only your deliveries
                @user = get_user_delivery  # Gets the whatever-its-called variable set up for the view
                @deliveries = @user.deliveries  # Gets the other whatever-its-called variable set up for the view
                clearErrorMessage # Safety check to clear the errors if any are there for some reason
            else
                addErrorMessage(session, "You cannot view another user's delivery page!")  # Adds error message if wrong user
                redirect_to user_deliveries_path(current_user(session))  # Redirects with error message
            end
        else
            addErrorMessage(session, "You need to be logged or to view your deliveries") # Adds error message if not logged in
            redirect_to login_path  # Redirects
        end
    end


    def new
        @message = assignMessage(session)
        if !(is_logged_in?(session))
            redirect_to login_path
        end
        if (isGuest(session))
        elsif !(isAdmin(session))
            if (get_user_delivery != current_user(session))
                addErrorMessage("Cannot make a delivery for someone else")
                redirect_to new_user_delivery_path(current_user(session))
            end
            @user = get_user_delivery
            @delivery = Delivery.new()
        else
        end
    end

    def payment_options
        binding.pry
    end

private



end


