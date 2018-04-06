Rails.application.routes.draw do
  get '/products' => 'products#index'
  root to: redirect('/products')
end
