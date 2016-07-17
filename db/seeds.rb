# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  name  = Faker::Name.name
  email = "example_#{n}@example.com"
  password = "password"
  User.create!(	
  							name:  name,
               	email: email,
               	password:              password,
               	password_confirmation: password
              )
end

users = User.order(:created_at)
10.times do
  users.each do |user| 
  	user.posts.create!(
  		title: Faker::Book.title, 
  		body: Faker::Hipster.paragraph(10, true) 
  	)
  end
end