# <<<<<<< Local Changes
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# <<<<<<< Local Changes
#
# If you want to add new data, comment out previous seeded data then
# run rake db:seed again
#
50.times do |i|
  user = User.new(name: Faker::Name.name,
                  email: Faker::Internet.email,
                  password: 123456)

  user.avatar = File.open("./public/profile_pictures/profile_#{(i % 10) + 1}.jpeg")

  user.addresses.new(address_line: Faker::Address.street_address,
                     city: Faker::Address.city,
                     state: Faker::Address.state,
                     zip_code: Faker::Address.zip_code)
  user.save
end

12.times do |i|
  group = Group.new(title: Faker::Commerce.product_name, description: Faker::Lorem.sentences.join, owner_id: "#{i + 1}")

  group.avatar = File.open("./public/group_pictures/group_#{(i % 10) + 1}.jpeg")

  group.addresses.new(address_line: Faker::Address.street_address,
                     city: Faker::Address.city,
                     state: Faker::Address.state,
                     zip_code: Faker::Address.zip_code)
  group.save

  user = User.find("#{i + 1}")

  GroupMember.create(user_id: user.id,
                     group_id: group.id,
                     name: user.name,
                     email: user.email)
end

100.times do |i|
  user = rand(50) + 1
  GroupMember.create(user_id: user,
                     group_id: "#{rand(12) + 1}",
                     name: User.find(user).name,
                     email: User.find(user).email)
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_time(from, to=(Time.now + 1.year))
  Time.at(rand_in_range(from.to_f, to.to_f))
end

50.times do |i|
  event = Event.new(title: Faker::Commerce.product_name,
                    description: Faker::Lorem.sentences.join,
                    date: rand_time(6.months.ago),
                    time: "#{rand(12) + 1}:#{rand(59) + 1}pm",
                    group_id: "#{rand(12) + 1}")

  event.avatar = File.open("./public/event_pictures/event_#{(i % 10) + 1}.jpeg")

  event.addresses.new(address_line: Faker::Address.street_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      zip_code: Faker::Address.zip_code)
  event.save!
end

# 24.times do |i|
#   EventSignup.create(event_id: (i + 1), attendee_id: 1)
# end


#
# We can use Faker here to create more authentic dummies
# Tim's Example:
#
# 100.times do |i|
#  User.create(email: Faker::Internet.safe_email,
#              password: Faker::Internet.password,
#              name: Faker::Name.name)
#end
#
#User.all.each do |user|
#  user.contact_details.create(
#    street_address: Faker::Address.street_address,
#    city: Faker::Address.city,
#    state: Faker::Address.state_abbr,
#    zip: Faker::Address.zip[0..4],
#    phone: Faker::PhoneNumber.phone_number,
#    country: "United States",
#    description: Faker::Lorem.paragraph(6),
#    website: Faker::Internet.url)
#end
#
#i = User.first.id
#
#while i < User.last.id do
#  if (i % 3 == 0)
#    user = User.find(i)
#    user.petitions.create(
#      title: Faker::Company.catch_phrase,
#      body: Faker::Lorem.paragraph(3),
#      background: Faker::Lorem.paragraph(6))
#  end
#
#  i += 1
#end=======
# >>>>>>> External Changes
# =======
# >>>>>>> External Changes
