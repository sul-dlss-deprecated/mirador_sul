Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [ :show ] do # users are managed internally
    resources :collections do
      resources :manifests, only: [ :show ] # manifests are managed under users
      resources :workspaces
    end
    resources :manifests
  end

  # read-only routes for sharing
  namespace :share do
    resources :collections, :manifests, :workspaces, only: [ :show ]
  end

end
