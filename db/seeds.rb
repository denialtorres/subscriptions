# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Stripe::Plan.create({
#   amount: 100000,
#   currency: 'usd',
#   interval: 'year',
#   product: 'prod_Jz1tnLj0HzKf7T',
#   id: 'large-annual'
# })
#
# Stripe::Plan.create({
#   amount: 10000,
#   currency: 'usd',
#   interval: 'month',
#   product: 'prod_Jz1tnLj0HzKf7T',
#   id: 'large-monthly'
# })
#
# Stripe::Plan.create({
#   amount: 25000,
#   currency: 'usd',
#   interval: 'year',
#   product: 'prod_Jz1tnLj0HzKf7T',
#   id: 'small-annual'
# })
#
# Stripe::Plan.create({
#   amount: 2500,
#   currency: 'usd',
#   interval: 'month',
#   product: 'prod_Jz1tnLj0HzKf7T',
#   id: 'small-monthly'
# })

Movie.create(title: 'Mugen Train', video_url: 'secret');

Plan.create(name: 'Small', stripe_id: "small-monthly", amount: 25_00, interval: 'month')
Plan.create(name: 'Small', stripe_id: "small-annual", amount: 250_00, interval: 'year')
Plan.create(name: 'Large', stripe_id: "large-monthly", amount: 100_00, interval: 'month')
Plan.create(name: 'Large', stripe_id: "large-annual", amount: 1000_00, interval: 'year')
