Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'search/input'
    post 'session/login'
    get 'session/logout'
    post 'session/logout'
    get 'session/login'
    post 'session/create'

    root 'main_room#main', as: 'main'
    get 'main_room/profile', as: 'profile'
    get 'main_room/join', as: 'join'
    get 'main_room/join_invite', as: 'join_invite'
    post 'main_room/roomjoininvite'
    post 'main_room/reject_invite', as: 'reject_invite'
    get 'main_room/showroom', as: 'showroom'
    get 'main_room/showhistory', as: 'history'
    post 'res', to: 'main_room#show'
    get 'main_room/rules', as: 'rules'

    post 'rooms/deleteuser', as: 'deleteuser'
    post 'rooms/lottery', as: 'lottery'
    get 'rooms/createroom', as: 'createroom'
    post 'rooms/destroy', as: 'destroyroom'
    post 'rooms/quit', as: 'quit'
    post 'rooms/roomjoin'

    get 'search/add', as: 'add'
    get 'search/input', as: 'search'
    post 'result', to: 'search#show'
    post 'search/addroom', as: 'addroom'

    post 'users/destroy', as: 'destroy'

    resources :users, :rooms
  end
end
