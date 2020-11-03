Rails.application.routes.draw do
   devise_for :users
  root 'books#top'
  get 'home/about' => 'books#about'
  resources :users, only: [:index, :edit, :update, :show]
 
  resources :books, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy] 
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
