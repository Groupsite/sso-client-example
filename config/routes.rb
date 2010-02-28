ActionController::Routing::Routes.draw do |map|

  map.login '/login', :controller => "sessions", :action => "new", :conditions => {:method => :get }
  map.logout '/logout', :controller => "sessions", :action => "destroy"

  map.resources :users
  map.resource :session
end
