class UsersController < ApplicationController

    def signup
        @message = SessionHelpers.sortErrorMsg(session)
        @user = User.new # makes a new unsaved user for the form_for form 
    end

    def create
        @user = User.new(user_params)
        if (@user.isFilled(session)) # Checks if the form was filled. If not it adds an error message 
            @user.save # Adds the new user to the databse
            SessionHelpers.clearErrorMessage(session) # Safety check, keeps session errors empty
            SessionHelpers.set_current_user(session, @user) # sets the current session 
            redirect_to users_path(@user) # send to the user show page
        else
            redirect_to sighup_path # Sends back to signin, this time with session[:errors] occupied
        end
    end

    def show
        if (@user.id != SessionHelpers.current_user(session).id) # You cannot see another user's page
            SessionHelpers.addErrorMessage(session, "You cannot view another user's page!")
            redirect_to users_path(SessionHelpers.current_user(session)) # Redirects to your own
        else
            @message = SessionHelpers.sortErrorMsg(session) # Sets up any error messages
            SessionHelpers.clearErrorMessage # Resents the error queue
            @user = find_user(params) 
        end
    end

    def delete
        @user = find_user
        if (@user != SessionHelpers.current_user(session))
            SessionHelpers.addErrorMessage(session, "You cannot delete someone else's account!")
            redirect_to user_path(SessionHelpers.current_user(session))
        else
        end
    end

    def hard_delete
        @user = find_user
        @user.delete 
        redirect_to welcome_path
    end

    def edit 
    end


private

    def user_params
        params.require(:user).permit(:address, :name, :email, :password)
    end

    def user_params(*)

    def find_user
        return User.find(params[:id])
    end

end