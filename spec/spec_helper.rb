require('rspec')
require('pry')
require('animal')
require('customer')
require('pg')

DB = PG.connect({:dbname => "shelter_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM animals *;")
    DB.exec("DELETE FROM customers *;")
  end
end
