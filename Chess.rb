require './Board.rb'
require './Piece.rb'
require './Player.rb'
require 'colorize'
require 'debugger'

class Chess

  def run
    board = Board.new

    # player 1 is blue, down, and starting
    @player1 = Player.new(board, :blue)
    @player2 = Player.new(board, :red)

    current_player = @player1

    board.reset_pieces(@player1, @player2)
    checkmate = false

    until checkmate
      puts "new turn! current player is #{current_player.color}, the current board: "
      board.display

      current_player.take_turn

      if other_player(current_player).in_check?
        puts "check - checking to see if checkmate..."
        checkmate = board.checkmate?(other_player(current_player))
        puts "check" unless checkmate
      end
      current_player = other_player(current_player) unless checkmate
    end
    puts "checkmate"
    board.display

  end

  def other_player(player)
    player == @player1 ? @player2 : @player1
  end

end

Chess.new.run