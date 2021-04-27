class Item < ActiveRecord::Base
    has_many :item_meals
    has_many :meals, through: :item_meals


    def show
        return "#{name} - $#{price}\n--#{description}"
    end

    def self.list_items(food_type)
        foods = Item.where(food_group: "Pizzas")
    end

    def self.meal_field_maker(foods)
        food.each do | sel |
            puts "<input type= 'checkbox' name= 'meal[items][], value= '#{sel.id}'> <#{sel.show}>"
        end
    end
end
