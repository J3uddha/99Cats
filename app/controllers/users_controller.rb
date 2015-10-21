class UsersController < ApplicationController

  before_action :redirect_signed_in_user, only: [:new]

  def redirect_signed_in_user
    redirect_to cats_url
  end

  def new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:notices] = ["Thanks for signing up! Welcome :)"]
      log_in!(@user)

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
