class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
       params[:user][:user_name],
       params[:user][:password]
     )
    session[:session_token] = @user.reset_session_token!

    unless @user.nil?
      log_in!(@user)
      
      redirect_to cats_url
    else
      flash[:notices] = ["Please enter a valid username and password."]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to cats_url
  end

  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
