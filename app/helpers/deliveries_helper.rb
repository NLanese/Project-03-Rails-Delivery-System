module DeliveriesHelper


# --------------------FORM STUFF--------------------------------------

    # Sets up the Address Field in a Delivery Form, has it preset to 
    # Match the User's Address if signed in. If guest it is blank
    def user_delivery_address_field(session)
        if (isGuest(session))
            return "<p>Address <input type= 'text' name= 'delivery[address]'></p>"
        elsif (is_logged_in?(session))
            return "<p>Address <input type= 'text' name= 'delivery[address]' value= '#{current_user(session).address}'></p>"
        else
            return "I haven't gotten here yet"
        end
    end

    # Creats different pathways for a form. If the params indicate the order is being
    # editted rather than created, it will post somewhere else. It can also handle 
    # guest deliveries
    def deliveryAction(session, delivery = nil)
        if isGuest(session)   # Guest overrules all. Guests cannot edit meals
            return "new_guest_delivery"
        elsif (delivery && delivery.items != [])
            return "edit_user_delivery"  # This means the delivery given already has items thus is being editted
        else
            return "new_user_delivery" # This means the delivery is empty and was just created in the new action
        end
    end



#--------------------SORTING STUFF-----------------------------------    
    # This will return an array of all deliveries that have been delivered
    def user_deliveries_completed(user)
        rArr = []
        user.deliveries.each do | sel |
            if sel.delivered == true
                rArr << sel
            end
        end
        if rArr.length == 0
            return nil
        else
            return rArr
        end
    end

    # This will return an array of all deliveries that have not yet been delivered
    def user_deliveries_pending(user)
        if (user.deliveries == [])
            return nil
        end
        rArr = []
        user.deliveries.each do | sel |
            if (sel.delivered == false || sel.delivered == nil)
                rArr << sel
            end
        end
        return rArr
    end



#-------------------RENDERING HTML---------------------------------------
    # This will take a delivery and render all of the important data in an organized manner
    def display_delivery(del)
        rStr = "<p>==================================================</p>\n<p>Contents:</p>"       # ==============================================
        rStr+=  del.meal.display.html_safe                                                         # Contents:
        rStr+= "\n"                                                                                # <meal>
        rStr+= "\nDeliver to #{del.address}"                                                       # Deliver to 98 Linden Avenue
        rStr+= "\nTotal: $#{del.price.round(2)}"                                                            # Total: $51.21
        rStr+= "\n=================================================="                              # ==============================================
        rStr+= "\n<strong><%= link_to 'Order Again', order_again_path(del)%></strong>"             # Order Again
        return rStr
    end

    # Takes an array of deliveries and runs the method above on each given delivery
    def display_deliveries(delArr)
        return delArr.each do | sel |
            display_delivery(sel).html_safe
        end
    end

end