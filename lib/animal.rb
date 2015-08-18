class Animal
  attr_reader(:id, :name, :gender, :type, :date, :breed, :customer_id, :pic)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i()
    @name = attributes.fetch(:name)
    @gender = attributes.fetch(:gender)
    @type = attributes.fetch(:type)
    @date = attributes.fetch(:date)
    @breed = attributes.fetch(:breed)
    @customer_id = attributes.fetch(:customer_id, 0).to_i()
    @pic = attributes.fetch(:pic)
  end

  define_singleton_method(:all) do
    unformatted_animals = DB.exec("SELECT * FROM animals ORDER BY name;")
    animals_output = []
    unformatted_animals.each do |animal|
      name = animal.fetch('name')
      gender = animal.fetch('gender')
      type = animal.fetch('type')
      date = animal.fetch('date')
      breed = animal.fetch('breed')
      customer_id = animal.fetch('customer_id').to_i()
      id = animal.fetch('id').to_i()
      pic = animal.fetch('pic')
      animals_output.push(Animal.new({:name => name, :gender => gender, :type => type, :date => date, :customer_id => customer_id, :pic => pic, :id => id, :breed => breed}))
    end
    animals_output
  end

  define_method(:==) do |other|
    name() == other.name() && gender() == other.gender()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO animals (name, gender, type, date, customer_id, pic, breed) VALUES ('#{@name}','#{@gender}','#{@type}','#{@date}','#{@customer_id}','#{@pic}','#{@breed}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:delete) do |id = nil|
    if id == nil
      DB.exec("DELETE FROM animals *;")
    else
      DB.exec("DELETE FROM animals * WHERE id=#{id}")
    end
  end

  define_singleton_method(:find) do |id|
    animals = DB.exec("SELECT * FROM animals WHERE id=#{id}")

    animals.each() do |animal|
      name = animal.fetch('name')
      gender = animal.fetch('gender')
      type = animal.fetch('type')
      date = animal.fetch('date')
      breed = animal.fetch('breed')
      customer_id = animal.fetch('customer_id').to_i()
      id = animal.fetch('id').to_i()
      pic = animal.fetch('pic')
      return Animal.new({:name => name, :gender => gender, :type => type, :date => date, :customer_id => customer_id, :pic => pic, :id => id, :breed => breed})
    end
  end
end
