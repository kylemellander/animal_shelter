require('capybara/rspec')
require('./app')
require('helper_spec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
