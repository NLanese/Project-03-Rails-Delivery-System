class DeliveriesController < ApplicationController
    include ApplicationHelper
    include ItemsHelper
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
        if (isGuest(session)) # handles guests differently
            @delivery = Delivery.new() # makes a blank delivery to assist the deliveryHelper method discern whether this is an edit or a new
        elsif !(is_logged_in?(session)) # Logged in?
            redirect_to login_path # Login
        elsif !(isAdmin(session)) 
            if (get_user_delivery != current_user(session)) # Correct user?
                addErrorMessage("Cannot make a delivery for someone else") # Correct user.
                redirect_to new_user_delivery_path(current_user(session)) # Go back
            end
            @user = get_user_delivery # generate user object for the view
            @delivery = Delivery.new() # makes a blank delivery to assist the deliveryHelper method discern whether this is an edit or a new
        else
            #Admin Stuff
        end
    end

    def payment_options
        payPar = delivery_with_meal_params()
        if (payPar[:meal_attributes][:name] == "")
            name = "Untitled Meal"
        end
        items = payPar[:meal_attributes][:items].map {| item_id | Item.find(item_id) }
        @meal = Meal.create(name: name, items: items)
        @delivery = Delivery.create(user: User.find(payPar[:user]), address: payPar[:address], meal: @meal)
    end


    def pay_with_cash
        redirect_to user_path(current_user(session)) # Thank god, this is easy
    end

    def pay_with_credit
        @user = User.find(params[:user_id]) # get the user
        @delivery = Delivery.find(params[:del_id]) # get the delivery 
        @user.credit = @user.credit - @delivery.price(@delivery.meal.price) # Credit = credit - price
        redirect_to user_path(current_user(session)) # back to home
    end

    def cancel_delivery
        Meal.last.delete # deletes the latest delivery (which is created the action right before this)
        Delivery.last.delete # check above
        redirect_to user_path(current_user(session))
    end

    # This will change a delivery from pending to delivered
    def completed
        @delivery = Delivery.find(params[:id])
        @delivery.update(delivered: true)
    end

private



end


