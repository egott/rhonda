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

  get '/', to: 'home#show'
  get 'bot/index', to: 'bot#index'
  post 'bot', to: 'bot#get_response'




end
