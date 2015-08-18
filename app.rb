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
