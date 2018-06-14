Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :drivers, defaults: {format: :json} 
      resources :vehicles, defaults: {format: :json} do
        resources :locations
      end
      resources :users, defaults: { format: :json }
    end
  end
end
