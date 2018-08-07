require 'ffaker'

User.destroy_all
Team.destroy_all

40.times do
  User.create(name: FFaker::Name.first_name, surname: FFaker::Name.last_name, email: FFaker::Internet.unique.email, password: 'test123#W', password_confirmation: 'test123#W', terms_of_service: true, skip_validation: true)
  print '.'
end

puts ' '
puts 'Users generated'

8.times do
  Team.create(name: FFaker::Company.name, description: FFaker::Company.bs)
  Team.last.users << User.order("RANDOM()").limit(10)
  print '.'
end

2.times do
  Team.create(name: FFaker::Company.name, description: FFaker::Company.bs)
  print '.'
end

puts ' '
puts 'Teams generated'

puts ' '
puts 'Data generated'
