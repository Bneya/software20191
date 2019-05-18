Rails.application.routes.draw do
  resources :modrequests do
    patch :accept
    put :accept
    patch :reject
    put :reject
    post :accept
    post :reject
    get :accept
    get :reject
    post :modrequest
    end
  

  resources :eventposts
  resources :campuses
  root to: 'pages#home'

  get 'users/index'

  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
  match 'campuses', to: 'campuses#index', via: 'get'
  match 'campuses/:id', to:'campuses#show', via: 'get'


  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]

  resources :classrooms
  resources :courses
  resources :posts
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # or
  resources :users, only: [:show]
  # root "events#index"

  # Acciones para botones de courses
  post 'courses/suscribe'
  post 'courses/desuscribe'
  post 'courses/modrequest'
  # Para dar likedislikes
  post 'posts/like'
  post 'posts/dislike'
  post 'postcomments/like'
  post 'postcomments/dislike'

  # Para comentarios de posts
  # post 'postcomments/create'
  resources :postcomments

  #
  resources :events
  # Schedule de las classrooms
  get "/pages/schedule", to: "pages#schedule", as: "schedule"
  post "/pages/schedule", to: "pages#schedule", as: "schedule_nav"

  # Eventos
  post "/events/new", to: "events#new", as: "shcedule_new_event"
  #post "/events/:id", to: "events#show", as: "schedule_event"
  #get "events/category"

  # Acciones para botones de eventos
  post 'events/suscribe'
  post 'events/desuscribe'

  # Salas
  post "/classrooms/:id", to: "classrooms#show", as: "schedule_classroom"

end
