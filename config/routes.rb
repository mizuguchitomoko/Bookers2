Rails.application.routes.draw do
  root 'books#top'
  resources :users, only: [:index, :edit, :show]
  devise_for :users


  resources :books, only: [:index, :new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
