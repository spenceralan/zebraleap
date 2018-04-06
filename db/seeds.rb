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
    Purchase.where(charge_id: "tok_010406_00#{index}").first_or_create \
      product_id: product.id,
      price_in_cents: product.price_in_cents,
      user_id: user.id,
      created_at: (index + ((index % 2 == 0) ? 10 : 1)).days.ago
  end
end
