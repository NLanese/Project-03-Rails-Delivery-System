class Item < ActiveRecord::Base
    has_many :item_meals
    has_many :meals, through: :item_meals


    def show
        return "#{name} - $#{price}\n--#{description}"
    end

    def shortShow
        return "#{name} - $#{price}"
    end

    def self.list_items(food_type)
        foods = Item.where(food_group: "food_type")
    end

    def self.meal_field_maker(foods)
        food.each do | sel |
            puts "<input type= 'checkbox' name= 'meal[items][], value= '#{sel.id}'> <#{sel.show}>"
        end
    end

    def self.edit_meal_field_maker(foods, delivery)
        food.each do | menu_item |
            matches = false
            delivery.meal.items.each do | del_item |
                if del_item.id == menu_item.id
                    matches = true
                end
            end
            if (matches)
                puts "<input type= 'checkbox' name= 'meal[items][], value= '#{sel.id}' checked> <#{sel.show}>"
            else
                puts "<input type= 'checkbox' name= 'meal[items][], value= '#{sel.id}'> <#{sel.show}>"
            end
        end
    end

end
