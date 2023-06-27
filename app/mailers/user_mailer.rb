class UserMailer < ApplicationMailer
  default from: "railsmailers@email.com"

  def welcome_email(user)
    # @user = params[:user]
    @user = user
    @url = "http://localhost:3000/users/sign_in"
    mail(to: @user.email, subject: "Welcome to alpha blog")
  end
end
