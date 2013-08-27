require './Board.rb'
require './Piece.rb'
require './Player.rb'
require 'colorize'

class Chess

  def run
    b = Board.new

    # player 1 is blue, down
    player1 = Player.new(b, :blue)
    player2 = Player.new(b, :red)

    b.reset_pieces(player1, player2)

    until b.checkmate?
      player1.take_turn
    end

  end



end

Chess.new.run