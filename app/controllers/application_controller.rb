# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'openssl'
require 'base64'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :logged_in?
  helper_method :current_user

  include SsoConfig

protected

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
    create_shared_session_cookie
    @current_user
  end

  def logout!
    session[:user_id] = nil
    cookies.delete(shared_cookie_name, :domain => shared_domain)
    @current_user = nil
  end

  def login_required
    unless logged_in?
      flash[:error] = "You must be logged in"
      redirect_to login_path
    end
  end

  def create_shared_session_cookie
    logger.info((cookies[shared_cookie_name] = {
      :value  => encrypt(current_user.to_pipe_delimited_string + "|expires_at=#{1.hours.from_now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")}"),
      :domain => shared_domain,
    }).inspect)
  end

  def encrypt(payload)
    c = OpenSSL::Cipher::Cipher.new("aes-256-cbc").encrypt
    c.key = c.iv = cypher_key
    Base64.encode64(c.update(payload) + c.final)
  end

end
