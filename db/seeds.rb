Product.find_or_create_by name: 'Premium - Ruby on Rails lesson' do |product|
  product.price_in_cents = 50000
end

User.find_or_create_by name: 'Test User' do |user|
  user.email = 'test@example.com'
end
