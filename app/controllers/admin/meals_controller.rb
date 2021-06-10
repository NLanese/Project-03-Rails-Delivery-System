class Admin::MealsController < ApplicationController 
    include ApplicationHelper

    def index 
        @filters = ["None", "Under Fifty Dollars", "Under One Hundred Dollars", "Over One Hundred Dollars", "Meals with a Name"]
        if (session[:filter] != "none")
        else
            @meals = Meal.all
        end
    end


    def delete
        if (isAdmin(session))
            @meal = Meal.find(params[:id])
            @meal.delete
            redirect_to admin_meals_path
        else
            addErrorMessage(session, "Only admins can delete meals")
            redirect_to user_path(current_user(session))
        end
    end
    
end