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
    resource :book_views, only: %i[create]
    collection do
      get "newsort", to: "books#newsort"
      get "starsort", to: "books#starsort"
    end
  end

  resources :users, only: %i[index show edit update] do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end

  resources :messages, only: %i[create]
  resources :rooms, only: %i[create index show]

  resources :groups, only: %i[new index show edit create destroy update] do
    resources :group_mails, only: %i[new show create]
    resource :group_users, only: %i[create destroy]
  end

  get 'search_result' => 'searches#search_result', as: 'search'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
