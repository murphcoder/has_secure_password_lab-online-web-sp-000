class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        if user_params[:password] == user_params[:password_confirmation]
            user = User.create(user_params)
            session[:user_id] = user.id
            redirect_to welcome_path
        else
            redirect_to signup_path
        end
    end

    def welcome
        return head(:forbidden) unless session.include? :user_id
        @user = User.find(session[:user_id])
    end

    private
 
    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end

end