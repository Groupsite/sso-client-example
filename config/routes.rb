SsoClientExample::Application.routes.draw do
  match '/login' => 'sessions#new', :as => :login, :via => :get
  match '/logout' => 'sessions#destroy', :as => :logout
  resources :users
  resource :session
end
