# frozen_string_literal: true

require_relative 'player'

# Main board + game logic class
class ConnectFour
  attr_reader :board

  def initialize(rows = 6, cols = 7)
    @board = initialize_board(rows, cols)
  end

  def initialize_board(rows, cols)
    Array.new(rows) { Array.new(cols, nil) }
  end

  def update_board(pos, symbol)
    @board.each do |row|
      if row[pos].nil?
        row[pos] = symbol
        break
      end
    end
  end

  def game_over?
  end
end
