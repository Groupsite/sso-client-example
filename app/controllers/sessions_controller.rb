class SessionsController < ApplicationController

  before_filter :check_already_logged_in!, :only => "new"

  def create
    @user = User.find_by_username_and_password(params[:username], params[:password])
    if @user
      self.current_user = @user
      if cookies["#{shared_cookie_name}_back_to"]
        redirect_to cookies["#{shared_cookie_name}_back_to"]
      else
        redirect_to url_for(@user)
      end
    else
      flash[:error] = "Login Failed"
      redirect_to :action => "new"
    end
  end

  def destroy
    logout!
    reset_session
    redirect_to login_path
  end

  protected

  def check_already_logged_in!
    redirect_to url_for(current_user) if current_user
    false
  end

end
