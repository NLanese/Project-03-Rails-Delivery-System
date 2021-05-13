class UsersController < ApplicationController 
    include ApplicationHelper
    skip_before_action :verify_authenticity_token, :only => [:funds_added]

    def signup
        @message = errorMsg(session)
        clearErrorMessage(session)
        @user = User.new # makes a new unsaved user for the form_for form 
    end

    def create
        @user = User.new(user_params)
        if (@user.isFilled(session)) # Checks if the form was filled. If not it adds an error message 
            User.all.each do | sel | # This checks every other user in the user-verse
                if @user.email == sel.email # This checks if this new (not yet saved) user's email matches an existing user's email
                    addErrorMessage(session, "That email is already taken!") # This says yeeeeet (correct error message)
                    @user.delete # Gets rid of the lame user account
                    redirect_to signup_path # redirects 
                end
            end
            @user.credit = 0
            @user.save # Adds the new user to the databse
            clearErrorMessage(session) # Safety check, keeps session errors empty
            set_current_user(session, @user) # sets the current session 
            redirect_to user_path(@user) # send to the user show page
        else
            addErrorMessage(session, "Please Fill all Fields") #Adds the correct error message
            redirect_to signup_path # Sends back to signin, this time with session[:errors] occupied
        end
    end

    def show
        @user = get_user
        if (@user.id != current_user(session).id) # You cannot see another user's page
            addErrorMessage(session, "You cannot view another user's page!") # correct error message
            redirect_to users_path(current_user(session)) # Redirects to your own
        else
            @message = errorMsg(session) # Sets up any error messages
            clearErrorMessage(session) # Resents the error queue
        end
    end

    def delete
        @user = get_user
        if (@user != current_user(session)) # if the user id entered in the request does not match the id of the user currently logged in
            addErrorMessage(session, "You cannot delete someone else's account!") # correct error message
            redirect_to user_path(current_user(session)) # d
        else
            #this opens the delete page which is a confirmation, does not yet actually delete
        end
    end

    def hard_delete   # This actually deletes the user. Only comes from delete.html.erb
        @user = get_user
        redirect_if_invalid(session)
        @user.delete 
        redirect_to welcome_path
    end

    def edit 
        @user = get_user
        redirect_if_invalid(session)
        @message = errorMsg(session)
    end

    def update
        @user = get_user
        if @user.authenticate(user_params[:password])
            if (user_params[:new_password] != "" )
                @user.password = user_params[:new_password]
            end
            @user.address = user_params[:address]
            @user.name = user_params[:name]
            @user.save
            redirect_to user_path(@user)
        else
            addErrorMessage(session, "You need to enter your previous password in order to change accounts details")
            redirect_to edit_user_path(@user)
        end
    end

    def add_funds
        @user = get_user
        redirect_if_invalid(session)
    end

    def funds_added
        @user = get_user
        @user.credit += user_params[:credit].to_f
        @user.save
        redirect_to user_path(@user)
    end


private

    def user_params
        params.require(:user).permit(:address, :name, :email, :password, :credit, :new_password)
    end

  #  def user_params(*args)
  #      params.require(:user).permit(*args)
  #  end

    def find_user
        return User.find(params[:id])
    end

end