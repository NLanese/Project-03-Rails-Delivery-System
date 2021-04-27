class CreateItemMeals < ActiveRecord::Migration[6.0]
    def change
      create_table :item_meals do |t|
        t.integer :meal_id
        t.integer :item_id
      end
    end
  end
  