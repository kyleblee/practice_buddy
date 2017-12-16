Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'welcome#index'

  get '/users/sign_up' => 'users#new'

  resources :users, only: [:index, :show, :edit, :update, :create] do
    resources :licks
    resources :tunes
  end
end
