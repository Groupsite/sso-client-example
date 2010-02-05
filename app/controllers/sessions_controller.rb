class SessionsController < ApplicationController

  def create
    @user = User.find_by_username_and_password(params[:username], params[:password])
    if @user
      self.current_user = @user
      redirect_to my_account_path
    else
      flash[:error] = "Login Failed"
      redirect_to :action => "new"
    end
  end
  
  def destroy
    reset_session
    cookies.delete(:cx_shssn, :domain => 'bioworksplace.dev')
    redirect_to login_path
  end
  
end