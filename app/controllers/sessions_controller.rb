class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        flash[:success] = "You have successfully logged in!" 
        # Saving user's id in the session's hash which is backed by browser's cookies
        session[:user_id] = user.id
        format.html {
          redirect_to user_path(user)
        }
      else
        flash.now[:danger] = "There was something wrong with your login information!"
        format.html {
          render(:new, status: :unprocessable_entity)
        }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out!"
    redirect_to root_path
  end
end
