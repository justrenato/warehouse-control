Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :material_logs
  resources :materials do
    post 'add', on: :collection
    post 'remove', on: :collection
  end

  get '/users', to: redirect('/')
  root to: "home#index"

end
