MeetupClone::Application.routes.draw do
  resources :users, only: [:new, :create]
end
