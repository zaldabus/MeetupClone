MeetupClone::Application.routes.draw do
  root to: 'roots#index'

  resources :roots, only: :index
  get 'find', to: 'roots#find'

  resources :users, only: [:new, :create, :show] do
      resources :groups, only: :index do
        get 'email_join', on: :collection
      end
  end

  resource :session, only: [:new, :create, :destroy]

  resource :account, only: [:show, :edit, :update]

  resources :groups, except: [:index, :destroy] do
    resources :members, only: [:index, :show]
    post 'join', on: :member

    resources :events, only: [:index, :show, :new, :create] do
      get 'past', on: :collection
      post 'event_signup', on: :member
    end
  end

end
