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
end
