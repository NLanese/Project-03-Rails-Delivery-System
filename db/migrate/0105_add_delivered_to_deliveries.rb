class AddDeliveredToDeliveries < ActiveRecord::Migration[6.0]
    def change
      add_column :deliveries, :delivered, :boolean, :defaut => false
    end
  end
  