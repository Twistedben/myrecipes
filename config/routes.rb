Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: "pages#home"
  
  resources :recipes
#Below, we set up the normal routes for chefs, but we exclude the :new route, and in place, set up a route manually to
#act as the new route. Telling it the verb is GET, the prefix "/signup" and the action 'chefs#new'
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :ingredients, except: [:destroy]
end 
