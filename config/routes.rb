Wes::Application.routes.draw do
  resources :users
  resources :doctors

  match '/signin',  :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#delete'
  resource :user_session

  root :to => 'users#index'
end
