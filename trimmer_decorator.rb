require_relative 'base_decorator'

class TrimmerDecorator < Decorator
  def correct_name
    name = @nameable.correct_name.to_s
    name.length > 10 ? name[0..9] : name
  end
end
