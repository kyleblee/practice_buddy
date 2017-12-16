Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/users/sign_up' => 'users#new'
  get '/users/sign_in' => 'session#new'
  get '/home' => 'session#index'
  get 'users/sign_out' => 'session#delete'

  resources :users, only: [:index, :show, :edit, :update, :create] do
    resources :licks
    resources :tunes
  end
end
