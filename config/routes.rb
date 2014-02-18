MeetupClone::Application.routes.draw do
  root to: "roots#index"

  # get '/account' => 'roots#account', as: 'account'
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resource :account, only: [:show, :edit, :update]

end
