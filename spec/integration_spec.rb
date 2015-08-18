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

  it("loads a page for all the customers") do
    visit('/')
    click_link('Customers')
    expect(page).to have_content("Willing Adopters")
    expect(page).to have_button("Add Customer")
  end

  it("adds customers to the customer list") do
    visit('/customers')
    fill_in('name', :with => "Christopher Robin")
    fill_in('phone', :with => "5")
    fill_in('animal_pref', :with => "Pig")
    fill_in('breed_pref', :with => "let")
    click_button('Add Customer')
    expect(page).to have_content('Christopher Robin')
  end

  it("adds matching customers and animals to the matches list") do
    test_customer = Customer.new({:name => 'Christopher Robin', :phone => "444-4444", :animal_pref => "Bear", :breed_pref => "Stuffed"})
    test_customer.save()
    test_animal = Animal.new({:name => "Winnie the Pooh", :type => "Bear", :breed => "Stuffed", :gender => "M", :date => "2015-08-17 00:00:00", :pic => "http://www.cartoonpics.net/data/media/33/gallery_poster_winnie_pooh.jpg"})
    test_animal.save()
    test_animal2 = Animal.new({:name => "Fluffy", :type => "Bear", :breed => "Grizzly", :gender => "F", :date => "2015-08-17 00:00:00", :pic => "blah"})
    test_animal2.save()
    visit('/customer')
    click_link('matches')
    expect(page).to have_content('Matches')
  end

  it("adopts a pet and then removes it from the list on the frontpage") do
    test_customer = Customer.new({:name => 'Christopher Robin', :phone => "444-4444", :animal_pref => "Bear", :breed_pref => "Stuffed"})
    test_customer.save()
    test_animal = Animal.new({:name => "Winnie the Pooh", :type => "Bear", :breed => "Stuffed", :gender => "M", :date => "2015-08-17 00:00:00", :pic => "http://www.cartoonpics.net/data/media/33/gallery_poster_winnie_pooh.jpg"})
    test_animal.save()
    test_animal2 = Animal.new({:name => "Fluffy", :type => "Bear", :breed => "Grizzly", :gender => "F", :date => "2015-08-17 00:00:00", :pic => "blah"})
    test_animal2.save()
    visit('/matches')
    click_link('matches')
    click_link('Adopt Winnie the Pooh')
    expect(page).to have_no_content('Winnie the Pooh')
  end


end
