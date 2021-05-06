module ApplicationHelper


    def get_user
        return User.find(params[:id])
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
            if (current_user(session) == find_user.id)
                return true
            else
                addErrorMessage(session, "You cannot view another user's delivery page!")
                redirect_to user_deliveries_path(current_user(session))
            end
        else
            addErrorMessage(session, "You need to be logged or to view your deliveries")
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
        session = nil
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

    def the_new_meal_form
        all_food_groups = Item.all.map do | sel |
            return sel.food_group
        end
        all_food_groups = all_food_groups.uniq
        all_food_groups.each do | sel |
            Item.meal_field_maker(sel)
        end
    end

    def the_edit_meal_form
        all_food_groups = Item.all.map do | sel |
            return sel.food_group
        end
        all_food_groups = all_food_groups.uniq
        all_food_groups.each do | sel |
            Item.meal_field_maker(sel)
        end
    end

end
