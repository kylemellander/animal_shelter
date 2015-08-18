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
  it("adds animals to the list") do
    visit('/')
    fill_in('name', :with => "Roo")
    fill_in('gender', :with => "M")
    fill_in('type', :with => "Kangaroo")
    fill_in('breed', :with => "Hoppy")
    fill_in('pic', :with => "http://vignette1.wikia.nocookie.net/winniethepooh/images/2/2a/Roo.PNG/revision/latest?cb=20081015165029")
    click_button('Add Animal')
    expect(page).to have_content('Roo')
  end
end
