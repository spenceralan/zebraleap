Product.find_or_create_by name: 'Fancy bottle of sparkling water' do |product|
  product.price_in_cents = 5000
end

User.find_or_create_by name: 'Test User' do |user|
  user.email = 'test@example.com'
end
