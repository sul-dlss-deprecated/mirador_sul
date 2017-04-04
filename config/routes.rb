Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :collections do
    resources :manifests, only: [:create, :destroy]
    resources :workspaces, only: [:new, :create]
  end

  resources :workspaces, only: [:index, :show, :destroy]

  resources :workspaces do
      resources :annotations, only: [:show, :new, :create, :index]
  end

  resources :annotations, only: [:show, :update, :destroy]
end
