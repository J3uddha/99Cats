class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.create(user_params)
    flash.notice = "Success"
    if @user.save

    else
      errors.add("base", "Please enter a valid username and password.")
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end


end
