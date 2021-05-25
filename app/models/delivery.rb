class Delivery < ActiveRecord::Base
    validates :address, presence: true

    belongs_to :meal
    accepts_nested_attributes_for :meals
    has_many :items, through: :meal
    belongs_to :user


    def price=(input)
        price = input * 1.07
        price = price + tip
        return price
    end

        

end
