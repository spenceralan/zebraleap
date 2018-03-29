Rails.application.routes.draw do
  resources :products, only: :index do
    member do
      get 'buy'
    end
  end

  root to: 'products#index'
end
