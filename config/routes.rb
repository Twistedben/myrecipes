Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: "pages#home"
#Below, we add all resources for recipes, but also make it a do block so that we create a nested route
#in order to add a route to create comments within the Recipe route. "/recipe/ID/comment"
  resources :recipes do
    resources :comments, only: [:create]
  end
#Below, we set up the normal routes for chefs, but we exclude the :new route, and in place, set up a route manually to
#act as the new route. Telling it the verb is GET, the prefix "/signup" and the action 'chefs#new'
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :ingredients, except: [:destroy]
#Below is the route this communication will go through.
  mount ActionCable.server => '/cable'
#Below, we create the routes for the Chatroom, to our chatrooms controller's show action.
  get '/chat', to: 'chatrooms#show'
#Below, we create a route path for new massges to be created
  resources :messages, only: [:create]
end 









