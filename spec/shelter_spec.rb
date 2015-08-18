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
    end
  end
end
