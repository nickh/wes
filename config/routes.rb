Wes::Application.routes.draw do
  resources :users
  resource :user_session

  root :to => 'users#index'
end
