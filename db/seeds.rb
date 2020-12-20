# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Roles
%w(Manager Assistant).each do |name|
  Role.create({name: name})
end
puts "===Role Created===="

# Create Shop
Shop.create(name: 'Vortex mobiles')
puts "===Shop Created===="

# Create Users
[{name: 'Maran', role_id: 1, shop_id: 1, email_id: 'maran@gmail.com'},
 {name: 'Chaitanya', role_id: 2, shop_id: 1, email_id: 'chaitanya@gmail.com'},
 {name: 'Prabha', role_id: 2, shop_id: 1, email_id: 'prabha@gmail.com'}].each do |user|
  user['password'] = Digest::MD5.hexdigest("#{user[:name]}357")
  User.create(user)
end
User.all.select{|user| user.active!}

puts "===One Manager and two assistant users Created===="

# create 2000 products

manufacturers = ['Apple', 'Mi', 'Oppo', 'Vivo', 'Lg', 'Motorola', 'Nokia', 'Realme', 'Samsung', 'Google pixel']
models = ['5S', '5C', '6', '6s', '7', '7S', '8', 'X', 'XS', 'XR', '11', '11 PRO', '11 PRO MAX', '12', '12 MINI', '12 PRO MAX']
storages = %w[32GB 64GB 16GB 8GB 4GB]
colors = %w[red black blue green]
prices = [4000, 8000, 10000, 12000, 15000, 18000, 20000,25000,28000,30000,35000,40000,45000,50000,60000,70000]
years = (1900..2020).to_a
a = []
(1..2000).to_a.each do |product|
  begin
    p = Product.new({manufacturer: manufacturers.sample, model: models.sample, storage: storages.sample,
                     color: colors.sample, price: prices.sample, year: years.sample, shop_id: 1})

    p.save!
  rescue => e
    a << p
    puts "==#{p.errors.messages}=="
  end
end
puts "===2000 products Created===="

