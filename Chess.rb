require './Board.rb'
require './Piece.rb'
require './Player.rb'
require 'colorize'

class Chess

  def run
    b = Board.new

    player1 = Player.new(@board, :blue)
    player2 = Player.new(@board, :red)

    p = Piece.new(b, :pawn, player1, nil)
    king = Piece.new(b, :king, player2, nil)
    b[0, 0] = p
    b[0, 1] = king
    b.display

  end



end

Chess.new.run