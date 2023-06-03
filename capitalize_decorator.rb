require_relative 'base_decorator'
class CapitalizeDecorator < Decorator
  def correct_name
    if @nameable.is_a?(String)
      @nameable.capitalize
    else
      @nameable
    end
  end
end
