module ItemsHelper
    include ApplicationHelper

    def meal_field_maker(foods, delivery = nil)
        rStr = ""
        if (delivery != nil)
            if (delivery.meal)
            foods.each do | sel |
                matches = false
                delivery.meal.items.each do | del_item |
                    if del_item.id == menu_item.id
                        matches = true
                    end
                end
                if (matches)
                    #"<p><input type= \"checkbox\" name= \"meal[items][]\" value= \"#{sel.id}\" 
                    rStr+= "<p><input type= \"checkbox\" name= \"meal[items][]\" value= \"#{sel.id}\" checked> <#{sel.show}></p>"
                else
                    rStr+= "<p><input type= \"checkbox\" name= \"meal[items][]\" value= \"#{sel.id}\" > <#{sel.show}>"
                end
            end
            end
        else
            foods.each do | sel |
                rStr += "<p><input type= 'checkbox' name= 'meal[items][]' value= '#{sel.id}'> #{sel.show} </p>"
            end
        end
        return rStr
    end

    def the_new_meal_form(delivery = nil)
        foodgroups = Item.get_foodgroups
        rStr = "<p>(Optional) Meal Name: <input type= 'text' name='meal[name]'></p>"
        foodgroups.each do | sel |
            rStr+= "\n<h3>#{sel}</h3>"
            groupedFoods = Item.list_items_of_group(sel)
            rStr += meal_field_maker(groupedFoods, delivery)
        end
        return (rStr)
    end

end
