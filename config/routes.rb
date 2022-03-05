Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      defaults format: :json do
        resources :users do 
          resources :accounts do
            resources :movements
          end
        end
        match 'accounts/:account_id/charge', to: 'movements#charge', via: :post
        match 'accounts/:account_id/payment', to: 'movements#payment', via: :post


        match '/login', to: 'users#login', via: [:get, :post], as: :login
        match '/register', to: 'users#register', via: [:get, :post], as: :register
      end
    end
  end
end
