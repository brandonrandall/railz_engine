Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'customers/find', to: 'customers/search#show'
      resources :customers, only: [:index, :show]
    end
  end
end
