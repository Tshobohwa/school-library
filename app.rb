require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  MENU_OPTIONS = [
    { option: 'Create a book', method: :create_book },
    { option: 'List all books', method: :list_all_books },
    { option: 'Create a person', method: :create_person },
    { option: 'List all people', method: :list_all_people },
    { option: 'Create a rental', method: :create_rental },
    { option: 'List all rentals', method: :list_all_rentals },
    { option: 'Exit', method: :exit }
  ].freeze

  def initialize
    @books = []
    @people = []
  end

  def run
    puts 'Welcome to the School Library App!'
    loop do
      display_options
      choice = gets.chomp.to_i

      if valid_choice?(choice)
        selected_option = MENU_OPTIONS[choice - 1]
        send(selected_option[:method])
        break if selected_option[:method] == :exit
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  private

  def display_options
    puts 'Please choose an option by entering a number:'
    MENU_OPTIONS.each_with_index { |option, index| puts "#{index + 1}. #{option[:option]}" }
  end

  def valid_choice?(choice)
    choice.between?(1, MENU_OPTIONS.length)
  end

  def create_book
    puts 'Title:'
    title = gets.chomp.capitalize
    puts 'Author:'
    author = gets.chomp.capitalize
    @books.push(Book.new(title, author))
    puts 'Book created successfully!'
  end

  def list_all_books
    if @books.empty?
      puts 'Book list is empty!'
    else
      @books.each { |book| puts "Title: #{book.title} Author: #{book.author}" }
    end
  end

  def create_person
    puts 'Select the type of person to create:'
    puts '1. Student'
    puts '2. Teacher'
    choice = gets.chomp.to_i

    case choice
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Classroom: '
    classroom = gets.chomp
    print 'Has parent permission? (Y/N): '
    parent_permission = gets.chomp.upcase

    until %w[Y N].include?(parent_permission)
      print 'Has parent permission? (Y/N): '
      parent_permission = gets.chomp.upcase
    end

    student = Student.new(age, classroom, name, parent_permission: parent_permission == 'Y')
    @people << student
    puts 'Person (student) created successfully!'
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Specialization: '
    specialization = gets.chomp

    @people << Teacher.new(age, specialization, name)
    puts 'Person (teacher) created successfully!'
  end

  def list_all_people
    if @people.empty?
      puts 'People list is empty!'
    else
      @people.each { |person| puts "ID: #{person.id} Name: #{person.name} Age: #{person.age}" }
    end
  end

  def create_rental
    if @books.empty? || @people.empty?
      puts 'Cannot create rental. Books or people list is empty!'
      return
    end

    puts 'Select a book from the following list by number:'
    @books.each_with_index { |book, index| puts "#{index}. Title: #{book.title} Author: #{book.author}" }
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not ID):'
    @people.each.with_index do |person, index|
      puts "#{index}. #{person.class.name} Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    puts 'Date (YYYY-MM-DD):'
    date = gets.chomp

    Rental.new(date, @people[person_index], @books[book_index])
    puts 'Created the rental successfully!'
  end

  def list_all_rentals
    if @people.empty?
      puts 'People list is empty!'
    else
      print 'ID of a person: '
      id = gets.chomp.to_i

      person_rental = @people.find { |person| person.id == id }

      if person_rental
        puts 'Rentals:'
        person_rental.rentals.each do |rental|
          puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
        end
      else
        puts 'Person not found! May be ID is incorrect.'
      end
    end
  end

  def exit
    puts 'Exiting the School Library App. Goodbye!'
  end
end
