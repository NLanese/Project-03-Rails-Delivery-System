module ApplicationHelper


    def user_delivery_address_field(session)
        if (isGuest(session))
            return "<p>Address <input type= 'text' name= 'delivery[address]'></p>"
        elsif (is_logged_in?(session))
            return "<p>Address <input type= 'text' name= 'delivery[address]' value= '#{current_user(session).address}'></p>"
        else
            return "I haven't gotten here yet"
        end
    end

    def get_user
        return User.find(params[:id].to_i)
    end

    def get_user_delivery
        return User.find(params[:user_id].to_i)
    end

    def clear_user(session)
        session[:user_id] = nil
    end

    def is_logged_in?(session)
        if session[:user_id]
            true 
        else
            false 
        end
    end

    def current_user(session)
        if session[:user_id]
            User.find(session[:user_id])
        else
            nil
        end
    end

    def redirect_if_invalid(session)
        if is_logged_in?(session)
            if (current_user(session) == get_user)
                return true
            else
                addErrorMessage(session, "You cannot view or edit something belonging to another user")
                redirect_to user_path(current_user(session))
            end
        else
            addErrorMessage(session, "You need to be logged or to view deliveries or accounts")
            redirect_to login_path
        end
    end

    def set_current_user(session, user)
        session[:user_id] = user.id 
    end

    def isAdmin(session)
        if current_user(session).admin
            true
        else
            false
        end
    end

    def isGuest(session)
        if session[:guest]
            true
        else
            false
        end
    end

    def addErrorMessage(session, msg)
        session[:errors] = msg
    end

    def clearErrorMessage(session)
        session[:errors] = nil
    end

    def clearSession(session)
        session = []
    end

    def has_errors?(session)
        if session[:errors]
            return true
        else
            return false
        end
    end

    def errorMsg(session)
        if (has_errors?(session)) # Checks if there were any previous signup errors
            return "Error, #{session[:errors]}" # Does the logic here instead of the view
        else
            return ""
        end
    end

    def user_deliveries_completed(user)
        rArr = user.deliveries.map do | sel |
            if sel.delivered == true
                return sel
            end
        end
        if rArr.length == 0
            return nil
        else
            return rArr
        end
    end

    def user_deliveries_pending(user)
        rArr = user.deliveries.map do | sel |
            if sel.delivered == false
                return sel
            end
        end
        if rArr.length == 0
            return nil
        else
            return rArr
        end
    end

    def display_delivery(del)
        rStr = "==================================================\nContents:"       # ==============================================
        rStr+= "\n" + del.meal.display                                               # Contents:
        rStr+= "\n"                                                                  # <meal>
        rStr+= "\nDeliver to #{del.address}"                                         # Deliver to 98 Linden Avenue
        rStr+= "\nTip: $#{del.tip}"                                                  # Tip: $10.00
        rStr+= "\nTotal: $#{del.price}"                                              # Total: $51.21
        rStr+= "\n=================================================="                # ==============================================
        rStr+= "\n<strong><%= link_to 'Order Again', order_again_path(del)%></strong>"# Order Again
        return rStr
    end

    def display_deliveries(delArr)
        delArr.each do | sel |
            display_delivery(sel)
        end
    end

    def assignMessage(session)
        if has_errors?(session)
            return errorMsg(session)
        else
            return ""
        end
    end

    def the_new_meal_form(delivery = nil)
        foodgroups = Item.get_foodgroups
        rStr = "<p>(Optional) Meal Name: <input type= 'text' name='meal[name]'></p>"
        foodgroups.each do | sel |
            rStr+= "\n<h3>#{sel}</h3>"
            groupedFoods = Item.list_items_of_group(sel)
            rStr += Item.meal_field_maker(groupedFoods, delivery)
        end
        return (rStr)
    end

    def makeDelivery(params)
        del_params= params.require(:delivery).permit(:user, :address, meal_attributes[:name, :items[]])
        meal params= params.require(:meal).permit(:items[])
        if (params[delivery][:meal] != "")
            mealName = params[:delivery][:meal]
        else
            neamlName = nil
        end
        delivery = Delivery.new(address: del_params[:address], user: User.find(del_params[:user]))
    end


end
