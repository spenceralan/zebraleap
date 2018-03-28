Rails.application.routes.draw do
  get 'products/:id/buy' => 'products#buy'
end
