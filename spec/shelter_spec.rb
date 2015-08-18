require('spec_helper')

describe(Animal) do
  describe(".all") do
    it('is empty at first') do
      expect(Animal.all).to(eq([]))
    end
  end

  describe("#save") do
    it('saves animals to the database') do
      test_animal = Animal.new({:name => "Roo", :type => "Kangaroo", :breed => "Hoppy", :gender => "M", :date => "2015-08-18 00:00:00", :pic => "http://vignette1.wikia.nocookie.net/winniethepooh/images/2/2a/Roo.PNG/revision/latest?cb=20081015165029"})
      test_animal.save()
      expect(Animal.all()).to(eq([test_animal]))
    end
  end

  describe(".delete") do
    it('deletes animals from animal array') do
      test_animal = Animal.new({:name => "Roo", :type => "Kangaroo", :breed => "Hoppy", :gender => "M", :date => "2015-08-18 00:00:00", :pic => "http://vignette1.wikia.nocookie.net/winniethepooh/images/2/2a/Roo.PNG/revision/latest?cb=20081015165029"})
      test_animal.save()
      Animal.delete()
      expect(Animal.all()).to(eq([]))
      test_animal.save()
      test_animal2 = Animal.new({:name => "Winnie the Pooh", :type => "Bear", :breed => "Stuffed", :gender => "M", :date => "2015-08-17 00:00:00", :pic => "http://www.cartoonpics.net/data/media/33/gallery_poster_winnie_pooh.jpg"})
      test_animal2.save()
      Animal.delete(test_animal.id())
      expect(Animal.all()).to(eq([test_animal2]))
    end
  end

  describe(".find") do
    it('finds an animal by id') do
      test_animal = Animal.new({:name => "Roo", :type => "Kangaroo", :breed => "Hoppy", :gender => "M", :date => "2015-08-18 00:00:00", :pic => "http://vignette1.wikia.nocookie.net/winniethepooh/images/2/2a/Roo.PNG/revision/latest?cb=20081015165029"})
      test_animal.save()
      test_animal2 = Animal.new({:name => "Winnie the Pooh", :type => "Bear", :breed => "Stuffed", :gender => "M", :date => "2015-08-17 00:00:00", :pic => "http://www.cartoonpics.net/data/media/33/gallery_poster_winnie_pooh.jpg"})
      test_animal2.save()
      expect(Animal.find(test_animal2.id())).to(eq(test_animal2))
    end
  end

  describe("#customer_id") do
    it("writes the customer_id of an animal") do
      test_animal = Animal.new({:name => "Roo", :type => "Kangaroo", :breed => "Hoppy", :gender => "M", :date => "2015-08-18 00:00:00", :pic => "http://vignette1.wikia.nocookie.net/winniethepooh/images/2/2a/Roo.PNG/revision/latest?cb=20081015165029"})
      test_animal.customer_id = 1
      expect(test_animal.customer_id()).to(eq(1))
    end
  end
end

describe(Customer) do
  describe(".all") do
    it("is empty at first") do
      expect(Customer.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves a customer") do
      test_customer = Customer.new({:name => 'Christopher Robin', :phone => "444-4444", :animal_pref => "bear", :breed_pref => "Stuffed"})
      test_customer.save()
      expect(Customer.all()).to(eq([test_customer]))
    end
  end

  describe(".delete") do
    it("deletes single and all customers") do
      test_customer = Customer.new({:name => 'Christopher Robin', :phone => "444-4444", :animal_pref => "Bear", :breed_pref => "Stuffed"})
      test_customer.save()
      Customer.delete()
      expect(Customer.all()).to(eq([]))
      test_customer.save()
      test_customer2 = Customer.new({:name => 'Kanga', :phone => "5", :animal_pref => "Kangaroo", :breed_pref => "Hoppy"})
      test_customer2.save()
      Customer.delete(test_customer.id())
      expect(Customer.all()).to(eq([test_customer2]))
    end
  end
end
