class UsersController < ApplicationController

  before_filter :login_required, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:info] = "Your account has been created"
      redirect_to my_account_path
    else
      render :action => "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:info] = "Your account was updated"
      redirect_to my_account_path
    else
      render :action => "edit"
    end
  end

end
