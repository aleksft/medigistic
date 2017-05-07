Medigistic::Application.routes.draw do

  devise_for :users, :controllers => { :registratrions => 'user/registratrions' }

  resources :medicines
  resources :users, only: [:show]
  resources :friendships

  root 'home#index'

  # Medicines
  get 'my_medicines',       to: 'users#my_medicines'
  get 'search_medicines',   to: 'medicines#search'

  # Friends
  get   'my_friends',       to: 'users#my_friends'
  get   'search_friends',   to: 'users#search'
  post  'add_friend',       to: 'user#add_friend'

end
