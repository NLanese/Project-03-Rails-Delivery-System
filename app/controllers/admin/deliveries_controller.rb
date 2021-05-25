class Admin::DeliveriesController < ApplicationController 
    include ApplicationHelper

    def index
        @deliveries = Delivery.all
    end

    def show
    end

    def edit
    end

    def update
    end

    def delete
    end

end