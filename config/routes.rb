Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'

  get 'auth/:provider/callback' => 'sessions#omniauth'
  get 'auth/failure', to: redirect('/')

  get '/signup' => 'sessions#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create, :show]
  resources :comments 
  resources :games do 
    resources :comments
  end
end