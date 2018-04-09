Rails.application.routes.draw do
  get 'products/:id' => 'products#show'
  get 'products/:id/buy' => 'products#buy'
  get 'purchases' => 'purchases#index'

  root to: redirect('/products/1')
end
