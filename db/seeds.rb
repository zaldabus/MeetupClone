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
5.times do |i|
  user = User.new(name: "User ##{i + 1}", email: "Email ##{i + 1}", password: 123456)
  user.addresses.new(address_line: "Someplace", city: "NY", state: "NY", zip_code: 10003)
  user.save
end

5.times do |i|
  Interest.create(title: "Interest ##{i + 1}", user_id: 1)
end

12.times do |i|
  group = Group.new(title: "Group ##{i + 1}", description: "This is a group", owner_id: 1)
  group.addresses.new(address_line: "Someplace", city: "New York", state: "NY", zip_code: 10003)
  group.save
end

12.times do |i|
  GroupMembership.create(member_id: 1, group_id: (i + 1))
end

# Upcoming Events

12.times do |i|
  event = Event.new(title: "Event ##{i + 1}", description: "This is an event", date: "2014/4/1", time: "7:00pm", group_id: (i + 1))
  event.addresses.new(address_line: "Someplace", city: "New York", state: "NY", zip_code: 10003)
  event.save

  event2 = Event.new(title: "Event ##{i + 1}", description: "This is an event", date: "2014/4/1", time: "7:00pm", group_id: (i + 1))
  event2.addresses.new(address_line: "Someplace", city: "New York", state: "NY", zip_code: 10003)
  event2.save
end

# Previous Events

12.times do |i|
  event = Event.new(title: "Event ##{i + 1}", description: "This is an event", date: "2013/4/1", time: "7:00pm", group_id: (i + 1))
  event.addresses.new(address_line: "Someplace", city: "New York", state: "NY", zip_code: 10003)
  event.save

  event2 = Event.new(title: "Event ##{i + 1}", description: "This is an event", date: "2013/4/1", time: "7:00pm", group_id: (i + 1))
  event2.addresses.new(address_line: "Someplace", city: "New York", state: "NY", zip_code: 10003)
  event2.save
end

24.times do |i|
  EventSignup.create(event_id: (i + 1), attendee_id: (i + 1))
end


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
