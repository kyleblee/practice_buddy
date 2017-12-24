Rails.application.routes.draw do

  root 'welcome#index'

  get '/users/sign_up' => 'users#new'
  get '/users/sign_in' => 'sessions#new'
  get '/home' => 'sessions#index'
  get 'users/sign_out' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'users#create'

  resources :sessions, only: [:create]

  resources :users, only: [:index, :show, :edit, :update, :create] do
    resources :licks
    resources :tunes
    resources :backing_tracks
  end

  resources :backing_tracks, only: [:show, :index]
end
