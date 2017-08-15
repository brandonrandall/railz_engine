Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      resources :customers, only: [:index, :show]
    end
  end
end
