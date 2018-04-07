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

users = 2.times.map do |index|
  name = "Test User #{index + 1}"

  User \
    .where(name: name)
    .first_or_create(email: "#{name.parameterize}@example.com")
end

programming_languages.each_with_index do |language, index|
  product = Product \
    .where(name: "Premium - #{language} lesson")
    .first_or_create(price_in_cents: index * 1100 + 500)

  unless language =~ /^[FGH]/
    Purchase.where(charge_id: "tok_010406_00#{index}").first_or_create \
      product_id: product.id,
      price_in_cents: product.price_in_cents,
      user_id: users[index % 2].id,
      created_at: (index + ((index % 2 == 0) ? 10 : 1)).days.ago
  end
end
