class UsersController < ApplicationController 
    include ApplicationHelper

    def signup
        @message = errorMsg(session)
        clearErrorMessage(session)
        @user = User.new # makes a new unsaved user for the form_for form 
    end

    def create
        @user = User.new(user_params)
        if (@user.isFilled(session)) # Checks if the form was filled. If not it adds an error message 
            User.all.each do | sel |
                if @user.email == sel.email
                    addErrorMessage(session, "That email is already taken!")
                    @user.delete
                    redirect_to signup_path
                end
            end
            @user.save # Adds the new user to the databse
            clearErrorMessage(session) # Safety check, keeps session errors empty
            set_current_user(session, @user) # sets the current session 
            redirect_to user_path(@user) # send to the user show page
        else
            addErrorMessage(session, "Please Fill all Fields")
            redirect_to signup_path # Sends back to signin, this time with session[:errors] occupied
        end
    end

    def show
        @user = get_user
        if (@user.id != current_user(session).id) # You cannot see another user's page
            addErrorMessage(session, "You cannot view another user's page!")
            redirect_to users_path(current_user(session)) # Redirects to your own
        else
            @message = errorMsg(session) # Sets up any error messages
            clearErrorMessage(session) # Resents the error queue
        end
    end

    def delete
        @user = get_user
        if (@user != current_user(session))
            addErrorMessage(session, "You cannot delete someone else's account!")
            redirect_to user_path(current_user(session))
        else
        end
    end

    def hard_delete
        @user = get_user
        @user.delete 
        redirect_to welcome_path
    end

    def edit 
        @user = get_user
    end

    def add_funds
        @user = get_user
    end

    def funds_added
        if (user_params(:credit).)
    end


private

    def user_params
        params.require(:user).permit(:address, :name, :email, :password, :credit)
    end

  #  def user_params(*args)
  #      params.require(:user).permit(*args)
  #  end

    def find_user
        return User.find(params[:id])
    end

end