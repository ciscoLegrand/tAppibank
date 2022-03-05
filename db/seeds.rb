# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
TYPE_ACCOUNT  = ['credito', 'debito']
TYPE_MOVEMENT = ['charge', 'payment']

5.times do
  user = User.create!(name: Faker::Name.first_name, last_name: Faker::Name.last_name, dni: Faker::IDNumber.unique.spanish_citizen_number, password: 'test123')
  user.accounts.create!(type_account: TYPE_ACCOUNT.sample, amount: Faker::Number.decimal(l_digits: 3))
end

15.times do 
  Movement.charge(account_id: rand(1..5), type_movement: TYPE_MOVEMENT.sample, amount: Faker::Number.decimal(l_digits: rand(1..4)), description: Faker::Lorem.sentence)
  Movement.payment(account_id: rand(1..5), type_movement: TYPE_MOVEMENT.sample, amount: Faker::Number.decimal(l_digits: rand(1..4)), description: Faker::Lorem.sentence)
end