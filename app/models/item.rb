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
end
