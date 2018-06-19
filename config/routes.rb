Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :drivers, defaults: {format: :json} 
      resources :vehicles, defaults: {format: :json} do
        resources :locations
      end
      resources :users, defaults: { format: :json }
      resources :itineraries
      resources :tasks
      resources :itinerary_items
      get '/vehicles/company_id/:company_id', to: 'vehicles#show_by_company_id', as: 'show_by_company_id'
    end
  end
end
