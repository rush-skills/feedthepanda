Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  namespace :api, :defaults => {:format => :json} do
	  namespace :v1 do
	    post '/login', to: "sessions#login"
	    get '/logged_in', to: "sessions#logged_in"
	    post '/register_gcm', to: "sessions#register_gcm"
	    get 'feed', to: "channels#feed"
	    get '/channels', to: 'channels#index'
	    get '/channels/:id/posts', to: 'channels#show'
	    post '/channels/:id/subscribe', to: 'channels#subscribe'
	    post '/channels/:id/unsubscribe', to: 'channels#unsubscribe'
	    post '/posts/:pid/mark_read', to: 'channels#mark_read'
	  end
	end

	resources :channels
	get '/feed', to: "channels#feed", as: :feed

  root to: 'visitors#index'
end
