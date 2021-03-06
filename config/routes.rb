Rails.application.routes.draw do
  get 'homes/index'
  get 'home/about' => 'homes#about', as: 'about'



  root 'homes#index'

  resources :books

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index,:show,:edit,:update]
end

