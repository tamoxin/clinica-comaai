# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(username: 'admin', password: 'admin', userType: 'admin', firstName: 'admin', lastName: 'admin', active: 1)

User.create(username: 'coordinator', password: 'coordinator', userType: 'coordinator', firstName: 'coordinator', lastName: 'coordinator', active: 1)

User.create(username: 'professor', password: 'professor', userType: 'professor', firstName: 'professor', lastName: 'professor', active: 1)

User.create(username: 'student', password: 'student', userType: 'student', firstName: 'student', lastName: 'student', active: 1)
