class ItemsController < ApplicationController


private

    def item_params
        params.require(:item).permit(:name, :price, :item_meal_id)
    end

end