Rails.application.routes.draw do
  devise_for :users
  # http_verb '/path', to: 'controller#action', as: :prefix
  # Prefix refers to the PATH only
  # Resouces is ONLY for the CRUD routes
  root to: 'restaurants#index'
  resources :restaurants do
    collection do
      get 'top'
    end
    member do
      get 'chef'
    end
    resources :reviews, only: [:create]
  end
  resources :reviews, only: [:destroy]

  # delete '/reviews/:id'
  # get '/restaurants/:id/chef', to: 'restaurants#chef', as: :restaurant_chef
  # get '/restaurants/top', to: 'restaurants#top', as: :top_restaurants
end

# Review.find(params[:id])
# NON-CRUD routes
# collection -> all restaurants (aka no ID)
# member     -> one specific restaurant (aka need the ID)

# HTTP Verbs
# get -> READ
# post -> CREATE
# patch -> UPDATE
# delete -> DELETE
