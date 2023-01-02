# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "destroying participants..."
Participant.destroy_all
puts "destroying events..."
Event.destroy_all
puts "destroying users..."
User.destroy_all

puts "creating users"

user1 = User.create(first_name: 'Benjamin',
                    last_name: 'Boulle',
                    email: 'benjaminboulle.sjb@gmail.com',
                    password: 'azerty')

puts "creating events"

event1 = Event.create(title: 'Snow Santa',
                      max_amount: 100,
                      user_id: user1)

puts "creating participant"

participant1 = Participant.create(first_name: 'Arthur',
                                  last_name: 'Peers',
                                  email: 'arthurpeeeers6@gmail.com',
                                  event_id: event1)

participant2 = Participant.create(first_name: 'Gideon',
                                  last_name: 'Maydell',
                                  email: 'gideooooon@maydell.at',
                                  event_id: event1)
