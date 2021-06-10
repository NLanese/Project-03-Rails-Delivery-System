class Admin::UsersController < ApplicationController 
    include ApplicationHelper

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user.address = user_params[:address]
        @user.name = user_params[:name]
        @user.save
        binding.ory
    end

    def delete
    end

end