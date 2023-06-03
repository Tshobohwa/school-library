class TrimmerDecorator < BaseDecorator
  def correct_name
    return @nameable.correct_name.strip[0..9] if @nameable.length > 10

    @nameable.correct_name
  end
end
