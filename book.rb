require_relative 'rental'
class Book
  attr_accessor :name, :author, :rentals, :title

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, person, self)
  end
end
