class MealsController < ApplicationController
    include ApplicationHelper
    include MealHelper
    skip_before_action :verify_authenticity_token, :only => [:index]

    def index 
        @filters = ["None", "Under Fifty Dollars", "Under One Hundred Dollars", "Over One Hundred Dollars", "Meals with a Name"]
        if (params[:filter] != nil && params[:filter] != "")
            filter = params[:filter]
            if (filter == "Under_Fifty_Dollars")
                @meals = under_fifty
            elsif(filter == "Under_One_Hundred_Dollars")
                @meals = under_100
            elsif(filter == "Over_One_Hundred_Dollars")
                @meals = over_100
            else
                @meals = named_only
            end
        else
            @meals = Meal.all
        end
    end

    def edit
        @meal = Meal.find(params[:id].to_i)
    end


    def delete
        if (isAdmin(session))
            @meal = Meal.find(params[:id])
            @meal.deliveries.each do | del |
                del.delete
            end
            @meal.delete
            redirect_to admin_meals_path
        else
            addErrorMessage(session, "Only admins can delete meals")
            redirect_to user_path(current_user(session))
        end
    end

end