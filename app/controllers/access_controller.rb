class AccessController < ApplicationController
   before_action :confirm_logged_in, only: [:home]
   before_action :prevent_login_signup, only: [:signup, :login]

   def signup
      @user = User.new
   end

   def create
      @user = User.create(user_params)
         if @user.save
            redirect_to '/home'
         else
            render :signup
         end
   end

   def attempt_login
      if params[:username].present? && params[:password].present?
         found_user = User.where(username: params[:username]).first
         if found_user
            authorized_user = found_user.authenticate(params[:password])
            if authorized_user
               flash[:good] = "Welcome"
               session[:user_id] = found_user.id
               session[:username] = found_user.username
               redirect_to '/home'
            else
               flash.now[:alert] = "Invalid Password!"
               render :login
            end
         else
             flash.now[:notice] = "User not found. Try again!"
               render :login
         end
      else
         flash.now[:notice] = "Type your password!"
         render :login
      end
   end


   def login
   end

   def home
   end

   def logout
      flash[:notice] = "You signed out successfully!"
      session[:user_id]= nil
      session[:foo]= nil
      redirect_to '/'
   end

   private

   def user_params
      params.require(:user).permit(:password, :username, :password_digest)
   end

   def prevent_login_signup
      if session[:user_id]
         redirect_to home_path
      end
   end

   def confirm_logged_in
      unless session[:user_id]
         redirect_to login_path, alert: "Please Log In!"
      end
   end

end
