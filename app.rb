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

post('/customer/new') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  animal_pref = params.fetch('animal_pref')
  breed_pref = params.fetch('breed_pref')
  Customer.new({:name => name, :phone => phone, :animal_pref => animal_pref, :breed_pref => breed_pref}).save()
  @success_message = "You have added #{name} to the list."
  @customers = Customer.all()
  erb(:customers)
end

get('/matches/:id') do
  id = params.fetch('id').to_i()
  @customer = Customer.find(id)
  @matches = @customer.find_match()
  @partial_matches = @customer.find_partial_match()
  erb(:matches)
end

get('/adopt/:customer_id/:animal_id') do
  id = params.fetch('animal_id').to_i()
  customer_id = params.fetch('customer_id').to_i()
  Animal.find(id).update_customer_id(customer_id)
  @animals = Animal.all()
  erb(:index)
end
