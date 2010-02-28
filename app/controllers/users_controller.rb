class UsersController < ApplicationController

  before_filter :login_required, :except => [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:info] = "Your account has been created"
      redirect_to login_url
    else
      render :action => "new"
    end
  end

  def show
    @user = User.find(params[:id])
    render :action => "edit"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:info] = "Your account was updated"
      redirect_to url_for(@user)
    else
      render :action => "edit"
    end
  end

end
