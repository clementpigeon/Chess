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

    current_player = player1

    b.reset_pieces(player1, player2)

    until b.checkmate?
      current_player.take_turn
      p "Is there a check on red? #{b.king(b.pieces_on_board[:red]).in_check?}"
      p "Is there a check on blue? #{b.king(b.pieces_on_board[:blue]).in_check?}"
      current_player = swap_current_player(current_player, player1, player2)

    end

  end

  def swap_current_player(current_player, player1, player2)
    return player1 if current_player == player2
    player2
  end



end

Chess.new.run