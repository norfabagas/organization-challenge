# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin role
user = User.create(
  name: 'Admin App',
  email: 'admin@mail.com',
  password: 'password',
  password_confirmation: 'password',
  phone: '081234567890',
  role: 'admin'
)

# Skip email confirmation
user.skip_confirmation!
user.save!