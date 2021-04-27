class CreateDeliveries < ActiveRecord::Migration[6.0]
    def change
      create_table :deliveries do |t|
        t.string :address
        t.integer :meal_id
        t.integer :user_id
        t.decimal :price
      end
    end
  end
  