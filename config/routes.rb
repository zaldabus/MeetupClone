MeetupClone::Application.routes.draw do
  root to: "roots#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
