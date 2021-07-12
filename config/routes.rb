Rails.application.routes.draw do
  post 'sessions/create'
  post 'sessions/destroy'
  resources :moods, only: [:create, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  get "/login" => "users#index"
  get "/signup" => "users#new"
end
