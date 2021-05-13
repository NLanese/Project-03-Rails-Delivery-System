class Item < ActiveRecord::Base
    has_many :item_meals
    has_many :meals, through: :item_meals


    def show
        return "#{name} - $#{price}\n--#{description}"
    end

    def shortShow
        return "#{name} - $#{price}"
    end

    def self.list_items_of_group(food_type)
        return Item.where(food_group: food_type)
    end

    def self.get_foodgroups
        rArr = Item.all.map do | sel |
            sel.food_group
        end
        rArr = rArr.uniq
        return rArr
    end

    def self.meal_field_maker(foods, delivery = nil)
        rStr = ""
        if (delivery.meal)
        foods.each do | sel |
            matches = false
            delivery.meal.items.each do | del_item |
                if del_item.id == menu_item.id
                    matches = true
                end
            end
            if (matches)
                puts "<p><input type= 'checkbox' name= 'meal[items][]' value= '#{sel.id}' checked> <#{sel.show}></p>"
            else
                puts "<input type= 'checkbox' name= 'meal[items][]' value= '#{sel.id}'> <#{sel.show}>"
            end
        end
        else
            foods.each do | sel |
                rStr += "<p><input type= 'checkbox' name= 'meal[items][], value= '#{sel.id}'> #{sel.show} </p>"
            end
        end
        return rStr
    end

end
