module ItemsHelper
    include ApplicationHelper

    def meal_field_maker(foods, meal = nil)
        rStr = ""
        if (meal != nil) # if there is a meal ( which there only is on edit actions)
            if (meal.items != [nil] && meal.items != [] && meal.items != nil) # double checks that it is not an empty meal for some reason
                allMealIds = meal.items.map do | itm | # gets every meal item's id into an array. This way can compare every item id with this array, if they share a similar number, that item's field will be checked
                    itm.id
                end
                foods.each do | sel | # goes through each food in the food_group
                    matches = false # assumes no match
                    allMealIds.each do | id | # goes through all of our existing meal's id's to see if one matches the current iteration's id
                        if sel.id == id
                            matches = true
                        end
                    end
                    if (matches)
                        #"<p><input type= \"checkbox\" name= \"meal[items][]\" value= \"#{sel.id}\" 
                        rStr+= "<p><input type= 'checkbox' name= 'delivery[meal_attributes][items][]' value= '#{sel.id}' checked > #{sel.show} </p>" #prints a check that is selected for items that exist in the meal
                    else
                        rStr+= "<p><input type= 'checkbox' name= 'delivery[meal_attributes][items][]' value= '#{sel.id}'> #{sel.show} </p>"  # prints a normal check field, unchecked.
                    end
                end
            end
        else
            foods.each do | sel |
                rStr += "<p><input type= 'checkbox' name= 'delivery[meal_attributes][items][]' value= '#{sel.id}'> #{sel.show} </p>"
            end
        end
        return rStr
    end

    def the_new_meal_form(meal = nil)
        foodgroups = Item.get_foodgroups
        if (meal != nil)
            rStr = "<p>(Optional) Meal Name: <input type='text' name='delivery[meal_attributes][name]' value=#{meal.name}></p>"
        else
            rStr = "<p>(Optional) Meal Name: <input type= 'text' name='delivery[meal_attributes][name]'></p>"
        end
        foodgroups.each do | sel |
            rStr+= "\n<h3>#{sel}</h3>"
            groupedFoods = Item.list_items_of_group(sel)
            rStr += meal_field_maker(groupedFoods, meal)
        end
        return (rStr)
    end

end
