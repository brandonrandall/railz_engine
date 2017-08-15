Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end

      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
