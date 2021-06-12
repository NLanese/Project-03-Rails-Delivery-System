class User < ActiveRecord::Base
    has_secure_password
    
    has_many :deliveries
    has_many :meals, through: :deliveries
    has_many :items, through: :meals

    def isFilled(session)
        if (address == "" || name == "" || email == "" || password_digest == "")
            return false
        else
            return true
        end
    end
end
