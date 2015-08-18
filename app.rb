require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/animal')
require('./lib/task')
require('pg')

DB = PG.connect({:dbname => "shelter"})
