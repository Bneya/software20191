Rails.application.routes.draw do
  get 'messages/index'

  get 'conversations/index'

  resources :saved_posts
  ActiveAdmin.routes(self)
  resources :classroomcomments
  resources :eventpostcomments
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


  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :eventposts
  resources :campuses
  root to: 'pages#home'

  get 'users/index'

  # User profiles
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
  resources :eventposts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # or
  resources :users, only: [:show]
  # root "events#index"

  # Acciones para botones de courses
  post 'courses/suscribe'
  post 'courses/desuscribe'
  post 'courses/modrequest'
  post 'courses/accept_request'
  post 'courses/reject_request'
  # Para dar likedislikes
  post 'posts/like'
  post 'posts/dislike'
  post 'posts/save_post'

  post 'postcomments/like'
  post 'postcomments/dislike'
  post 'saved_posts/create_new'

  # Para comentarios de posts
  # post 'postcomments/create'
  resources :postcomments
get "campuses/x_coor"
  get "campuses/y_coor"
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

  # Para dar likedislikes
  post 'eventposts/like'
  post 'eventposts/dislike'
  post 'eventpostcomments/like'
  post 'eventpostcomments/dislike'
  post 'classroomcomments/like'
  post 'classroomcomments/dislike'
  post 'classrooms/like_noise'
  post 'classrooms/dislike_noise'
  post 'classrooms/like_disponibility'
  post 'classrooms/dislike_disponibility'
  post 'classrooms/like_sockets'
  post 'classrooms/dislike_sockets'


  # Salas
  # post "/classrooms/:id", to: "classrooms#show", as: "schedule_classroom"

end
