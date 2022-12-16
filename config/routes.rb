Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'search/input'
    post 'session/login'
    get 'session/logout'
    post 'session/logout'
    get 'session/login'
    post 'session/create'
    post 'main_room/roomjoin'
    get 'main_room/profile', as: 'profile'
    root 'main_room#main', as: 'main'
    get 'rooms/createroom'
    get 'main_room/join', as: 'join'
    get 'main_room/join_invite', as: 'join_invite'
    post 'main_room/roomjoininvite'
    post 'main_room/reject_invite', as: 'reject_invite'
    get 'main_room/quit', as: 'quit'
    post 'main_room/quit/:id', to: 'main_room#quit'
    get 'main_room/showroom', as: 'showroom'
    get 'main_room/showroom/:id', to: 'main_room#showroom'
    get 'main_room/deleteuser', as: 'deleteuser'
    post 'main_room/deleteuser/:id', to: 'main_room#deleteuser'
    post 'main_room/lottery', as: 'lottery'
    get 'search/input', as: 'search'
    post 'result', to: "search#show"
    get 'search/add', as: 'add'
    post 'search/addroom', as: 'addroom'
    resources :users
    resources :rooms
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
