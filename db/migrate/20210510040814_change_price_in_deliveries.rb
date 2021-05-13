class ChangePriceInDeliveries < ActiveRecord::Migration[6.0]
    def change
      remove_column :deliveries, :price
      add_column :deliveries, :price, :float
    end
  end
