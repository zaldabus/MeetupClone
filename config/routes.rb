MeetupClone::Application.routes.draw do
  root to: 'roots#index'

  resources :roots, only: :index
  get 'find', to: 'roots#find'

  resources :users, only: [:new, :create, :show] do
      resources :groups, only: :index
  end

  resource :session, only: [:new, :create, :destroy]

  resource :account, only: [:show, :edit, :update]

  resources :groups, except: [:index, :destroy]

end
