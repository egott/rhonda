Rails.application.routes.draw do
  # stock settings:
  # get 'sessions/create'
  #
  # get 'sessions/destroy'
  #
  # get 'home/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # our settings:
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"

  get 'bots/index', to: 'bots#index'
  post 'bots', to: 'bots#create'

end
