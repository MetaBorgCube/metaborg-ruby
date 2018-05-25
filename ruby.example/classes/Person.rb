class Person
  def name=(name)
    puts "Naming your person #{name}!"
    @name = name
  end

  alias full_name= name=
end

p = Person.new
p.name = "David"        # Naming your person David!

class Person
  def name=(name)
    puts "Please use full_name="
  end
end

p.name = "Joe"          # Please use full_name=
p.full_name = "Joe"     # Naming your person Joe!