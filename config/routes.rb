Rails.application.routes.draw do

root 'welcome#home'
get '/signin', to: 'sessions#new'
post '/signin', to: 'sessions#create'
get '/signout', to: 'sessions#destroy'
post '/attractions/:id', to: 'attractions#ride', as: 'take_ride'
resources :users
resources :attractions
end