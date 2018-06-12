Rails.application.routes.draw do
  #mount Rswag::Ui::Engine => '/api-docs'
  #mount Rswag::Api::Engine => '/api-docs'
  mount SwaggerUiEngine::Engine, at: "/"
  namespace :api do
    namespace :v1 do
      resources :drivers, defaults: {format: :json} 
      resources :vehicles, defaults: {format: :json} do
        resources :locations
      end
    end
  end
end
