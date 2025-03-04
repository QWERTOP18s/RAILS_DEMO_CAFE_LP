require 'securerandom'

drinkNames = %w[blend-coffee cafe-au-lait espresso]
mealNames = %w[croissant pancake bagle]
etcNames = %w[beans]

def getRefPath(name)
  Rails.root.join("public/product_refs/#{name}.jpeg")
end

def attachRef(product, name)
  path = getRefPath(name)
  if File.exist?(path)
    product.ref.attach(io: File.open(path), filename: "#{name}.jpeg", content_type: "image/jpeg")
    puts "Attached #{name}.jpeg to #{product.name}"
  else
    puts "Warning: #{name}.jpeg not found in public/product_refs/"
  end
end

drinkNames.each do |name|
  p = Product.create!(
    uid: SecureRandom.uuid,
    name: name,
    cost: 100,
    price: 400,
    description: "drink",
    category: "drink",
  )
  attachRef(p, name)
end

mealNames.each do |name|
  p = Product.create!(
    uid: SecureRandom.uuid,
    name:name,
    cost: 500,
    price: 1000,
    description: "meal",
    category: "meal",
  )
  attachRef(p, name)
end

etcNames.each do |name|
  p = Product.create!(  
    uid: SecureRandom.uuid,
    name: name,
    cost: 1000,
    price: 1000,
    description: "etc",
    category: "etc",
  )
  attachRef(p, name)
end


Product.create!(
  uid: SecureRandom.uuid,
  name: "nosrc",
  cost: 1000,
  price: 1000,
  description: "no reference",
  category: "meal",
)



