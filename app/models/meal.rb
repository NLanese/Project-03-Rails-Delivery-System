class Meal < ActiveRecord::Base
    has_many :item_meals
    has_many :items, through: :item_meals
    has_many :deliveries
    has_many :users, through: :deliveries


    def price
        total = 0
        deliveries.each do | sel |
            total = total + sel.price
        end
    end

    def self.find_vegetarian(meals)
        veggies = []
        meals.each do | meal |
            veggie = true
            meal.items.each do | item |
                if (item.food_group == "Chicken" || item.food_group == "Hot Sandwiches" || item.food_group == "Cold Sandwiches" || item.name = "Specialty Pie") 
                    veggie = false
                end
            end
            if veggie
                veggies << meal
            end
        end
    end

    def self.underThirty(meals)
        under30 = []
        meals.each do | meal |
            if meal.price < 30
                under30 << meal
            end
        end
    end

    def self.sandwiches(meals)
        sandwiches = []
        meals.each do | meal |
            sandwich = true 
            meal.items.each do | item |
                if ((item.food_group != "Hot Sandwiches") && (item.food_group != "Cold Sandwiches"))
                    sandwich = false
                end
            end
            if (sandwich)
                sandwiches << meal
            end
        end
    end

    def meal_user_id_field(session)
        if SessionHelpers.is_logged_in(session)
            hidden_field_tag meal[user_id] = SessionHelpers.current_user.id
        else
            hidden_field_tag meal[user_id] = nil
        end
    end
                


end
