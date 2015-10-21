class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:notices] = ["Thanks for signing up! Welcome :)"]
      redirect_to cats_url
    else
      @user.errors.add("base", "Please enter a valid username and password")
      flash[:notices] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end


end
