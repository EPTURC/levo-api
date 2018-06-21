Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :drivers, defaults: {format: :json} 
      resources :vehicles, defaults: {format: :json} do
        resources :locations
      end
      resources :users, defaults: { format: :json }
      resources :itineraries do
        resources :itinerary_items
      end
      resources :tasks
      resources :occurrences
      get '/vehicles/company_id/:company_id', to: 'vehicles#show_by_company_id', as: 'show_by_company_id'
      get '/itineraries/driver/:driver', to: 'itineraries#show_by_driver', as: 'show_by_driver'
      get '/drivers/name/:name', to: 'drivers#show_by_name', as: 'show_by_name'
    end
  end
end
