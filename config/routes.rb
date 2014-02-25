MeetupClone::Application.routes.draw do
  root to: 'roots#index'

  resources :roots, only: :index
  get 'find', to: 'roots#find'
  get 'find_date', to: 'roots#find_date'

  resources :users, only: [:new, :create, :show] do
    post 'comment', on: :member

    resources :groups, only: :index do
      get 'email_join', on: :collection
    end
  end

  resource :session, only: [:new, :create, :destroy]

  resource :account, only: [:show, :edit, :update] do
    get 'change_password', on: :collection
    get 'change_address', on: :collection
    get 'notifications', on: :collection
  end

  resources :groups, except: [:index, :destroy] do
    get 'join', on: :member

    resources :members, only: [:index, :show] do
      post 'comment', on: :member
    end

    resources :events, only: [:index, :show, :new, :create] do
      get 'past', on: :collection
      post 'event_signup', on: :member
      post 'comment', on: :member
    end
  end

  resources :notifications, only: [:destroy, :show]

end
