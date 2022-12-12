Rails.application.routes.draw do
  post 'session/login'
  get 'session/logout'
  post 'session/logout'
  get 'session/login'
  post 'session/create'
  post 'main_room/roomjoin'
  get 'main_room/profile', as: 'profile'
  root 'main_room#main', as: 'main'
  # get 'main_room/createroom', as: 'create'
  get 'rooms/createroom'
  get 'main_room/join'
  get 'main_room/quit', as: 'quit'
  post 'main_room/quit/:id', to: 'main_room#quit'
  get 'main_room/showroom', as: 'showroom'
  get 'main_room/showroom/:id', to: 'main_room#showroom'
  resources :users
  resources :rooms
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
