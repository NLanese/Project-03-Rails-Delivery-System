module MealHelper

    def under_fifty
        rArr = []
        Meal.all.each do | meal |
            if meal.price < 50
                rArr << meal
            end
        end
        return rArr
    end

    def under_100
        rArr = []
        Meal.all.each do | meal |
            if meal.price < 100
                rArr << meal
            end
        end
        return rArr
    end

    def over_100
        rArr = []
        Meal.all.each do | meal |
            if meal.price > 100
                rArr << meal
            end
        end
        return rArr
    end

    def named_only
        rArr = []
        Meal.all.each do | meal |
            if meal.name != "Untitled Meal"
                rArr << meal
            end
        end
        return rArr
    end
end