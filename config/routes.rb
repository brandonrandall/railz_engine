Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #NEED TO DO THE LONGHAND NAMESPACING TOO!
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'find#show'
        # get '/find_all', to: 'find#index'
      end
      resources :items, only: [:index, :show]

      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
