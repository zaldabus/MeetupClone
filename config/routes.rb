MeetupClone::Application.routes.draw do
  root to: 'roots#index'

  resources :roots, only: :index
  get 'find', to: 'roots#find'

  resources :users, only: [:new, :create, :show] do
      resources :groups, only: :index
  end

  resource :session, only: [:new, :create, :destroy]

  resource :account, only: [:show, :edit, :update]

  resources :groups, except: [:index, :destroy] do
    resources :members, only: [:index, :show]
    post 'join', on: :member

    resources :events, only: [:index, :show] do
      get 'past', on: :collection
      resources :event_signups, only: :create
    end
  end



end
