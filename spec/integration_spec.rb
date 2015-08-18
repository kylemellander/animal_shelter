require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("/", {:type => :feature}) do
  it("shows proper content on the index page") do
    visit('/')
    expect(page).to have_content("Hundred Acre Wood")
    expect(page).to have_button("Add Animal")
  end
end
