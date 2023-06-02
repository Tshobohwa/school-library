class Student < Person
    def initialize(age, classroom, name, parent_permission)
        super (age, name, parent_permission)
        @classroom = classroom
    end

    def play_hoocky
        return "¯\(ツ)/¯"
    end
end
