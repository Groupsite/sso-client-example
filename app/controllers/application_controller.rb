# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :logged_in?
  helper_method :current_user
  helper_method :groupsite_url

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by_id(session[:user_id])
  end
  
  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end
  
  def logout!
    session[:user_id] = nil
    @current_user = nil
  end
  
  def login_required
    unless logged_in?
      flash[:error] = "You must be logged in"
      redirect_to login_path
    end
  end
  
  def groupsite_url
    "http://network.bioworksplace.dev"
  end
  
end
