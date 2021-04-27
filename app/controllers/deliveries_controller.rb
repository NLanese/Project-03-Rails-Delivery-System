class DeliveriesController < ApplicationController



private

    def delivery_params
        params.require(:delivery, meal).permit(:address, :order_user_id, :total_price, :delivered, meal: [:name, items:[]])
    end 
end