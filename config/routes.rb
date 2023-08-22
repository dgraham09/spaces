Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/show'
  get 'bookings/edit'
  get 'bookings/new'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :spaces do
    resources :bookings
  end
end
