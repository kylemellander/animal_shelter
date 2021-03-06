class Customer
  attr_reader(:name, :phone, :animal_pref, :breed_pref, :id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i()
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @animal_pref = attributes.fetch(:animal_pref)
    @breed_pref = attributes.fetch(:breed_pref)
  end

  define_singleton_method(:all) do |id = nil|
    if id == nil
      returned_customers = DB.exec("SELECT * FROM customers;")
    else
      returned_customers = DB.exec("SELECT * FROM customers WHERE id=#{id};")
    end
    customers = []
    returned_customers.each() do |customer|
      id = customer.fetch('id').to_i
      name = customer.fetch('name')
      phone = customer.fetch('phone')
      animal_pref = customer.fetch('animal_pref')
      breed_pref = customer.fetch('breed_pref')
      customers.push(Customer.new({:id => id, :name => name, :phone => phone, :animal_pref => animal_pref, :breed_pref => breed_pref}))
    end
    customers
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO customers (name, phone, animal_pref, breed_pref) VALUES ('#{@name}', '#{@phone}', '#{@animal_pref}', '#{@breed_pref}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |other|
    name() == other.name() && phone() == other.phone() && animal_pref() == other.animal_pref() && breed_pref() == other.breed_pref()
  end

  define_singleton_method(:delete) do |id = nil|
    if id != nil
      DB.exec("DELETE FROM customers * WHERE id=#{id};")
    else
      DB.exec("DELETE FROM customers *;")
    end
  end

  define_method(:find_match) do
    matches = []
    Animal.all().each() do |animal|
      if animal.breed().downcase() == @breed_pref.downcase() && animal.type().downcase() == @animal_pref.downcase()
        matches.push(animal)
      end
    end
    matches
  end

  define_method(:find_partial_match) do
    partial_matches = []
    Animal.all().each() do |animal|
      if animal.breed().downcase() != @breed_pref.downcase() && animal.type().downcase == @animal_pref.downcase()
        partial_matches.push(animal)
      end
    end
   partial_matches
 end

  define_singleton_method(:find) do |id|
    Customer.all().each do |customer|
      if customer.id() == id
        return customer
      end
    end
  end

end
