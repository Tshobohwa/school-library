class Person
    attr_reader :id
    attr_accessor :name, :age
    def initialize(  age, name = "Unknown", parent_permission = true)
        @name = name
        @age = age
        @parent_permission = parent_permission
    end

    def can_use_services?
        return true if of_age? || @parent_permission == true
    end

    private
    
    def of_age?
        return true if @age >=18
        return false
    end

end

me = Person.new("Salomon", 23, false)
puts me