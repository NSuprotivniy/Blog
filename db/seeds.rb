# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do |n|
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

puts "  Users created"

users = User.all.shuffle.take(20)
2.times do
  users.each do |user|
  	user.posts.create!(
  		title: Faker::Book.title,
  		body: Faker::Hipster.paragraph(10, true)
  	)
  end
end

puts " Posts created"

posts = Post.all
users = User.all.shuffle.take(2)
posts.each do |post|
  5.times do
    users.each do |user|
      comment = post.comments.build(body: Faker::Hipster.paragraph(2, true))
      comment.user = user
      comment.save!
    end
  end
end

puts "  Comments created"

puts "  Done!"
