require './Board.rb'
require './Piece.rb'
require './Player.rb'
require 'colorize'

class Chess

  def run
    b = Board.new

    # player 1 is blue, down, and starting
    player1 = Player.new(b, :blue)
    player2 = Player.new(b, :red)

    current_player = player1

    b.reset_pieces(player1, player2)
    checkmate = false

    until checkmate
      current_player.take_turn
      current_player = swap_current_player(current_player, player1, player2)
      checkmate = b.checkmate?(player1, player2)
      puts "check" if current_player.in_check? && !checkmate
    end

    puts "checkmate"

  end

  def swap_current_player(current_player, player1, player2)
    return player1 if current_player == player2
    player2
  end

end

Chess.new.run