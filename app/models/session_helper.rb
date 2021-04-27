class SessionHelpers

    def self.is_logged_in?(session)
        if session[:user_id]
            true 
        else
            false 
        end
    end

    def self.current_user(session)
        if session[:user_id]
            session[:user_id]
        else
            nil
        end
    end

    def self.set_current_user(session, user)
        session[:user_id] = user.id 
    end

    def self.isAdmin(session)
        if SessionHelpers.current_user(session).admin
            true
        else
            false
        end
    end

    def self.isGuest(session)
        if session[:guest]
            true
        else
            false
        end
    end

    def self.addErrorMessage(session, msg)
        session[:errors] = msg
    end

    def self.clearErrorMessage(session)
        session[:errors] = nil
    end

    def self.clearSession(session)
        session = []
    end

    def self.has_errors?(session)
        if session[:errors]
            return true
        else
            return false
        end
    end

    def sortErrorMsg(session)
        if (SessionHelpers.has_errors(session)) # Checks if there were any previous signup errors
            return "Error, #{session[:errors]}" # Does the logic here instead of the view
        else
            return ""
        end
    end

end
    