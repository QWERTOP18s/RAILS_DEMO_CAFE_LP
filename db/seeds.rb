require 'securerandom'

drinkNames = %w[blend-coffee cafe-au-lait espresso]
mealNames = %w[croissant pancake bagle]

drinkNames.each do |name|
  Product.create!(
    uid: SecureRandom.uuid,
    name: name,
    cost: 100,
    price: 400,
    ref: "#{name}.jpeg",
    description: "coffee",
    category: "drink",
  )
end

mealNames.each do |name|
  Product.create!(
    uid: SecureRandom.uuid,
    name:name,
    cost: 500,
    price: 1000,
    ref: "#{name}.jpeg",
    description: "meal",
    category: "meal",
  )
end

Product.create!(
  uid: SecureRandom.uuid,
  name: "nosrc",
  cost: 1000,
  price: 1000,
  description: "no reference",
  category: "meal",
)



