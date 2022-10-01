# frozen_string_literal: true

require_relative 'connect_four'

game = ConnectFour.new
game.visualize_board
puts nil
4.times do
  game.update_board(1, 'A')
end
game.visualize_board
game.vertical_check
