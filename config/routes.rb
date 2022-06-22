Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :books, only: %i[index show edit create destroy update] do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, only: %i[create destroy]
    resource :book_views, only: [:create]
  end
  resources :users, only: %i[index show edit update] do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :messages, only: [:create]
  resources :rooms, only: %i[create index show]

  get 'search_result' => 'searches#search_result', as: 'search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
