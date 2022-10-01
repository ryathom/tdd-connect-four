# frozen_string_literal: true

# Player class for Connect Four game
class Player
  def initialize(name, symbol, width)
    @name = name
    @symbol = symbol
    @game_width = width
  end

  def verify_input(input)
    return nil unless input.is_a?(Integer)
    return input if input.between?(0, @game_width - 1)
  end
end
