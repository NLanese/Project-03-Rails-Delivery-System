module SessionHelper

    def set_up_login(session, user)
        clearErrorMessage(session)
        session[:filter] = "none"
        set_current_user(session, user)
        session[:guest] = false
        session[:admin] = false
        session[:user_id] = user.id
    end

end