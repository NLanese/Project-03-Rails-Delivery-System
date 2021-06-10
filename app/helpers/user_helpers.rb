modulde UserHelpers

def isAdmin(session)
    if SessionHelpers.current_user(session).admin
        true
    else
        false
    end
end

def isGuest(session)
    if session[:guest]
        true
    else
        false
    end
end

end