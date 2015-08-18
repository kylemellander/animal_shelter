require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/animal')
require('./lib/customer')
require('pg')

DB = PG.connect({:dbname => "shelter"})

get('/') do
  @animals = Animal.all()
  erb(:index)
end

post('/animal/new') do
  name = params.fetch('name')
  gender = params.fetch('gender')
  type = params.fetch('type')
  breed = params.fetch('breed')
  pic = params.fetch('pic')
  time = Time.new()
  Animal.new({:name => name, :gender => gender, :type => type, :breed => breed, :pic => pic, :date => time}).save()
  @success_message = "You have added #{name} the #{breed} #{type}."
  @animals = Animal.all()
  erb(:index)
end

get('/customers') do
  @customers = Customer.all()
  erb(:customers)
end
