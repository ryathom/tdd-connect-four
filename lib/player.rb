# frozen_string_literal: true

# Player class for Connect Four game
class Player
  attr_reader :symbol, :name

  def initialize(name, symbol, width)
    @name = name
    @symbol = symbol
    @game_width = width
  end

  def verify_input(input)
    return nil unless input.is_a?(Integer)
    return input if input.between?(0, @game_width - 1)
  end

  def player_input
    puts "#{@name}, choose a column - enter a number between 0 and #{@game_width - 1}"
    loop do
      input = gets.chomp
      input = input.to_i if input.match?(/^\d+$/)
      input = verify_input(input)
      return input unless input.nil?
      puts "Input error! Please enter a number between 0 and #{@game_width - 1}."
    end
  end
end
