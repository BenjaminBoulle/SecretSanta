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

puts "creating users..."

user1 = User.create(first_name: 'Benjamin',
                    last_name: 'Boulle',
                    email: 'benjaminboulle7@gmail.com',
                    password: 'azerty')

puts "creating events..."

event1 = Event.create(title: 'Snow Santa',
                      max_amount: 100,
                      user: user1)

event2 = Event.create(title: 'Red Santa',
                      max_amount: 200,
                      user: user1)

puts "creating participant..."

puts "event1..."
participant1 = Participant.create(first_name: event1.user.first_name,
                                  last_name: event1.user.last_name,
                                  email: event1.user.email,
                                  event: event1)

participant2 = Participant.create(first_name: 'Arthur',
                                  last_name: 'Peers',
                                  email: 'arthurpeeeers6@gmail.com',
                                  event: event1)

participant3 = Participant.create(first_name: 'Gideon',
                                  last_name: 'Maydell',
                                  email: 'gideooooon@maydell.at',
                                  event: event1)

puts "event2..."
participant4 = Participant.create(first_name: event2.user.first_name,
                                  last_name: event2.user.last_name,
                                  email: event2.user.email,
                                  event: event2)

participant5 = Participant.create(first_name: 'Marie',
                                  last_name: 'Altieri',
                                  email: 'maaaaarie@gmail.com',
                                  event: event2)

participant6 = Participant.create(first_name: 'Daphne',
                                  last_name: 'Lefevre',
                                  email: 'daaaaaaaphne@gmail.com',
                                  event: event2)

p participant1
p participant2
p participant3
p participant4
p participant5
p participant6
