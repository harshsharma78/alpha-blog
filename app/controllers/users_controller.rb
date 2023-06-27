class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :edit]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        # UserMailer.with(user: @user).welcome_email.deliver_later
        session[:user_id] = @user.id
        flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
        format.html {
          redirect_to user_path(@user)
        }
        format.json {
          render json: @user, status: :created, location: @user
        }
      else
        # format.html {
        #   render(:new, status: :unprocessable_entity)
        # }
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Your account was successfully updated!"
        format.html {
          redirect_to articles_path
        }
      else
        format.html {
          render(:edit, status: :unprocessable_entity)
        }
      end
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted!"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account!"
      redirect_to root_path
    end
  end

  def require_admin
    if (user_signed_in? and !current_user.admin?)
      flash[:danger] = "Only admin can perform that action!"
    end
  end
end
