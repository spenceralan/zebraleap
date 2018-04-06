Rails.application.routes.draw do
  get 'products/:id' => 'products#show'

  root to: redirect('/products/1')
end
