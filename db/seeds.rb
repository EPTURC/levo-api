# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{name: 'João da Costa'}, {name: 'Eiji Adachi'}, {name: 'Paula Costa'}, 
             {name: 'Antônio Fagundes'}, {name: 'Stenio Garcia'}])
Driver.create([{user_id: 4}, {user_id: 5}])
