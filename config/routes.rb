Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      get '/drivers/available', to: 'drivers#show_available', as: 'show_available_drivers'
      get '/vehicles/available', to: 'vehicles#show_available', as: 'show_available_vehicles'
      resources :drivers, defaults: {format: :json} 
      resources :vehicles, defaults: {format: :json} do
        resources :locations
      end
      get '/users/admins', to: 'users#admin_index', as: 'admin_index'
      resources :users, defaults: { format: :json }
      resources :itineraries do
        resources :itinerary_items
      end
      resources :tasks
      resources :occurrences
      resources :messages
      get '/vehicles/company_id/:company_id', to: 'vehicles#show_by_company_id', as: 'show_by_company_id'
      get '/itineraries/driver/:driver', to: 'itineraries#show_by_driver', as: 'show_by_driver'
      get '/drivers/name/:name', to: 'drivers#show_by_name', as: 'show_by_name'
      get '/messages/driver/:driver', to: 'messages#select_by_driver', as: 'select_by_driver'
    end
  end
end
