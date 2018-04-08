Rails.application.routes.draw do
  get 'products/:id' => 'products#show'
  get 'products/:id/buy' => 'products#buy'

  root to: redirect('/products/1')
end
