ActionController::Routing::Routes.draw do |map|
  
  # These are the URLs used by the bioworks app
  map.join '/Account/Account.aspx', :controller => "users", :action => "new", :conditions => {:method => :get }
  map.connect '/Account/Account.aspx', :controller => "users", :action => "create", :conditions => {:method => :post }

  map.login '/Login.aspx', :controller => "sessions", :action => "new", :conditions => {:method => :get }
  map.connect '/Login.aspx', :controller => "sessions", :action => "create", :conditions => {:method => :post }
  
  map.logout '/Logout.aspx', :controller => "sessions", :action => "destroy"
  
  map.change_password '/Account/EditPassword.aspx', :controller => "users", :action => "change_password"
  map.reset_password '/Password/ForgotPassword.aspx', :controller => "users", :action => "reset_password"
  map.my_account '/Account/AccountEdit.aspx', :controller => "users", :action => "edit"

  map.resources :users
end
