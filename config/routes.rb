MeetupClone::Application.routes.draw do
  root to: "roots#index"

  resources :users, only: [:new, :create]
  get '/account' => 'users#account', as: 'account'
  resource :session, only: [:new, :create, :destroy]

end
