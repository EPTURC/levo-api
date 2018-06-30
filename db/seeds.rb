# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Occurrence.all.destroy_all
ItineraryItem.all.destroy_all
Task.all.destroy_all

Itinerary.all.destroy_all
Location.all.destroy_all
Vehicle.all.destroy_all
Driver.all.destroy_all
User.all.destroy_all


User.create([
    { name: 'Antônio Fagundes', email: "antonio@email.com", password: "12345678" },
    { name: 'Stenio Garcia', email: "stenio@email.com", password: "12345678" },
    { name: 'Paula Costa', email: "paula@email.com", password: "12345678" },
    { name: 'João da Costa', email: "joao@email.com", password: "12345678"},
    { name: 'Eiji Adachi', email: "eiji@email.com", password: "12345678", is_admin:true }])

Driver.create([{ user_id: User.first.id }, { user_id: User.second.id }, { user_id: User.third.id }, { user_id: User.fourth.id }] )
Vehicle.create([{ company_id: 'HHT-01'}, {company_id: 'Horch-01'}, {company_id: 'Cometa'} ])
Location.create([{ vehicle_id: Vehicle.first.id , latitude: '-5.830272', longitude: '-35.201803' },
                {vehicle_id: Vehicle.second.id, latitude: '-5.812057', longitude: '-35.20714' },
                {vehicle_id: Vehicle.second.id, latitude: '-5.812059', longitude: '-35.20714' }])
Itinerary.create([ {driver_id: Driver.first.id, vehicle_id: Vehicle.first.id, status: 'ativo'}, 
                {driver_id: Driver.second.id, vehicle_id: Vehicle.second.id, status: 'inativo'},
                {driver_id: Driver.third.id, vehicle_id: Vehicle.third.id, status: 'ativo'} ])
Task.create([ {object: "Caderno sem capas", responsible_name: "Maria", type: "Coleta", local: "-23.01265, -24.02124"}, 
              { object: "Móvel 10kg", responsible_name: "João", type: "Entrega", local: "-25.2003, -25.1201"} ])
ItineraryItem.create([ { itinerary_id: Itinerary.first.id, index: 1, done: false, task_id: Task.first.id },
                        { itinerary_id: Itinerary.first.id, index: 2, done: false, task_id: Task.second.id } ])
Occurrence.create([ { type: "Quebra de carro", location: "Av. Moema Tinoco, 202", description: "Tinha um buraco na estrada!", driver_id: Driver.first.id, 
                        itinerary_id: Itinerary.second.id , solved: false}, 
                    { type: "Quebra de carro", location: "Av. João Silva Tinoco, 202", description: "Estava chovendo", 
                    driver_id: Driver.second.id, itinerary_id: Itinerary.first.id, solved: true}])