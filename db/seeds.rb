# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  user = User.new(name: "User ##{i + 1}", email: "Email ##{i + 1}", password: 123456)
  user.addresses.new(address_line: "Someplace", city: "NY", state: "NY", zip_code: 10003)
  user.save
end

5.times do |i|
  Interest.create(title: "Interest ##{i + 1}", user_id: 1)
end

12.times do |i|
  Group.create(title: "Group ##{i + 1}", description: "This is a group", owner_id: 1)
end

12.times do |i|
  GroupMembership.create(member_id: 1, group_id: (i + 1))
end