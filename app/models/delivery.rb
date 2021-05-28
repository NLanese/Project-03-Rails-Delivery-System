class Delivery < ActiveRecord::Base
    validates :address, presence: true

    belongs_to :meal
    accepts_nested_attributes_for :meal
    has_many :items, through: :meal
    belongs_to :user


    def price
        meal.price * 1.07
    end

        

end
