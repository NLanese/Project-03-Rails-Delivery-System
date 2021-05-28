module ApplicationHelper


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

    def assignMessage(session)
        if has_errors?(session)
            return errorMsg(session)
        else
            return ""
        end
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

    def user_or_guest_meal_id(session)
        if (isGuest(session))
            return '<input type= "hidden" name= "delivery[user]" value="-100"'
        else
            return "<input type= \"hidden\" name= \"delivery[user]\" value=\"#{current_user(session).id}\""
        end
    end

    def delivery_with_meal_params()
        params.require(:delivery).permit(:user, :address, meal_attributes:[:name, :items => []])
    end

    def get_meal_items(arr_of_ids)
        arr_of_ids.map do | sel |
            Item.find(sel.to_i)
        end
    end

    def redirect_if_not_admin(session)
        if (isAdmin(session))
            return true
        else
            redirect_to application/welcome
        end
    end

    def isGreaterThan(entry1, entry2)
        if (entry1 >= entry2)
            return true
        else
            false
        end
    end

    def nicksDebugger(badCode, goodCode = nil)
        badString = badCode
        goodString = goodCode
        puts (badString)
        puts (goodString)
        binding.pry
    end

end
