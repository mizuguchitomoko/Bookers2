Rails.application.routes.draw do
  root 'books#top'
   devise_for :users
  resources :users, only: [:index, :edit, :update, :show]



  resources :books, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
