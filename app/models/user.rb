class User < ActiveRecord::Base
    has_secure_password
    validates :name, presence: true
    validates :username, presence: true
    validates :password, presence: true
    
    has_many :deliveries
    has_many :meals, through: :deliveries
    has_many :items, through: :meals

    def isFilled(session)
        if (address == "" || name == " " || email == "" || password_digest == "")
            SessionHelpers.addMessage(session, "Please Fill all Fields")
            return false
        else
            return true
        end
    end
end
