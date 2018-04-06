programming_languages = [
  'AppleScript',
  'BASIC',
  'C++',
  'Delphi',
  'Elm',
  'F#',
  'Go',
  'Haskell',
  'JavaScript',
  'Ruby',
]

user = User.find_or_create_by name: 'Test User' do |user|
  user.email = 'test@example.com'
end

programming_languages.each_with_index do |language, index|
  product = Product.find_or_create_by name: "Premium - #{language} lesson" do |product|
    product.price_in_cents = index * 1100 + 500
  end

  unless language =~ /^[FGH]/
    Purchase.find_or_create_by charge_id: "tok_010406_00#{index}" do |purchase|
      purchase.product_id = product.id
      purchase.price_in_cents = product.price_in_cents
      purchase.user_id = user.id
      purchase.purchased_at = (index + ((index % 2 == 0) ? 10 : 1)).days.ago
    end
  end
end
