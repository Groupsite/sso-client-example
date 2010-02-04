class SessionsController < ApplicationController

  def create
    @user = User.find_by_username_and_password(params[:username], params[:password])
    if @user
      redirect_to_groupsite
    else
      flash[:error] = "Login Failed"
      redirect_to :action => "new"
    end
  end
  
end