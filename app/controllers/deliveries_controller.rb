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

    def edit
        @delivery = Delivery.find(params[:id])
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
            
        else
            #Admin Stuff
        end
    end

    def payment_options
        payPar = delivery_with_meal_params()
        if (payPar[:meal_attributes][:name] == "")
            name = "Untitled Meal"
        else
            name = payPar[:meal_attributes][:name]
        end
        items = payPar[:meal_attributes][:items].map {| item_id | Item.find(item_id.to_i) }
        compArr = items.map do | itm |  # I'm doing this becausew for some reason Meal.find(items: items) always returns nil even when the items match an existing meal
            itm.id
        end
        Meal.all.each do | m | # so much extra work my god
            matcher = true
            testArr = m.items.map do | itm |
                itm.id
            end
            testArr = testArr.sort() # sorts all the id's of the currently selected meal
            compArr = compArr.sort() # sorts all the id's of the new meal
            if (compArr.length == testArr.length)
                len = compArr.length # lets me set up a f*****king while loop because thats what I have to do now to compare EACH ITEM 
                i = 0
                while (i < len)
                    if compArr[i] != testArr[i] # if a sorted item in our new meal does not equal the sorted id of this meal, then it is not the same meal
                        matcher = false
                    end # no else, because if that conditional above is never hit and the lengths are thge same, matches will be true
                    i+= 1
                end
                if (matcher) # if it goes through the entire id array and both are identical (same meal contents)
                    @meal = m
                end
            end
        end
        if (@meal == nil)
            @meal = Meal.create(name: name, items: items)
            @meal.times_purchased = 0
        end
        binding.pry
        @delivery = Delivery.create(user: User.find(payPar[:user]), address: payPar[:address], meal: @meal, price: (@meal.price * 1.07).round(2))
    end


    def pay_with_cash
        @delivery = Delivery.find(params[:del_id])
        @delivery.meal.times_purchased+= 1
        @delivery.meal.items = @delivery.meal.items.uniq
        @delivery.save
        redirect_to user_path(current_user(session)) # Thank god, this is easy
    end

    def pay_with_credit
        @user = User.find(params[:user_id]) # get the user
        @delivery = Delivery.find(params[:del_id]) # get the delivery 
        @delivery.meal.times_purchased+= 1
        @delivery.meal.items = @delivery.meal.items.uniq
        @user.credit = @user.credit - @delivery.price # Credit = credit - price
        @user.save
        @delivery.save
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
        redirect_to user_path(current_user(session))
    end

    def order_again_path

    end

private



end


