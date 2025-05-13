Rails.application.routes.draw do
  # http_verb '/path', to: 'controller#action', as: :prefix
  # Prefix refers to the PATH only
  # Read all -> index
  root to: 'restaurants#index'
  get '/restaurants', to: 'restaurants#index', as: :restaurants
  # Create
  # we need a page for a form
  get '/restaurants/new', to: 'restaurants#new', as: :new_restaurant
  # we need a place to send the data from the form
  post '/restaurants', to: 'restaurants#create'
  # Read one -> show
  get '/restaurants/:id', to: 'restaurants#show', as: :restaurant
  # Update
  # just for the form
  get '/restaurants/:id/edit', to: 'restaurants#edit', as: :edit_restaurant
  # we need a place to send the data from the form
  patch '/restaurants/:id', to: 'restaurants#update'
  # Destroy
  delete '/restaurants/:id', to: 'restaurants#destroy'
end

# HTTP Verbs
# get -> READ
# post -> CREATE
# patch -> UPDATE
# delete -> DELETE
