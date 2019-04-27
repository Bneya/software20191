Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # or
  resources :users, only: [:show]
  root "events#index"

  # Acciones para botones de courses
  post 'courses/suscribe'
  post 'courses/desuscribe'

  #
  resources :events
  #get "events/category"

end
