require_relative 'person'
class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
    classroom.students << self unless classroom.students.includes? self
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
