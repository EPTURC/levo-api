# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{ name: 'João da Costa' }, { name: 'Eiji Adachi' }, { name: 'Paula Costa' }, 
             { name: 'Antônio Fagundes'}, { name: 'Stenio Garcia'}])
Driver.create([{ user_id: 4 }, { user_id: 5 }])
Vehicle.create([{ company_id: 'HHT-01'}, {company_id: 'Horch-01' } ])
Location.create([{ vehicle_id: 1, latitude: '-5.830272', longitude: '-35.201803' }, 
                {vehicle_id: 2, latitude: '-5.812057', longitude: '-35.20714' }])