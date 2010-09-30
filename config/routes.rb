Wes::Application.routes.draw do
  resources :users
  resources :doctors do
    resources :reviews
  end

  match '/signin',  :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy'
  resource :user_session

  root :to => 'doctors#index'
end
