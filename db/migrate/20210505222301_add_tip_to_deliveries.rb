class AddTipToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :tip, :decimal
  end
end
