Rails.application.routes.draw do
   devise_for :users
  root 'books#top'
  get 'home/about' => 'books#about'
  get 'search' => 'searches#search'
  resources :users, only: [:index, :edit, :update, :show] do
    resources :relationships, only: [:create, :destroy]
    resources :parents
    get 'relationships/create'
    get 'relationships/destroy'
  end
 
  resources :books, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy] 
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
