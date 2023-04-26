Rails.application.routes.draw do
  get 'chats/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  get 'relationships/following'
  get 'relationships/follower'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'follower', to: 'relationships#follower', as: 'follower'
    get 'search', to: 'users#search'
  end
  get 'search', to: 'searches#search'
  resources :groups, only: [:new, :create, :edit, :update, :index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
