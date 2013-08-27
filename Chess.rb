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

    # p = Piece.new(b, :pawn, player1, nil)
    # king = Piece.new(b, :king, player2, nil)
    # b[0, 0] = p
    # b[0, 1] = king
    player1.take_turn
    b.display

  end



end

Chess.new.run