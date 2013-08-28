require './board_reset_methods.rb'

class Board

  attr_accessor :pieces

  def initialize
    @board = empty_board
    @pieces = []
  end

  def display
    #puts "board".colorize :red
    puts "   " + ('a'..'h').to_a.join(' ')
    @board.each_with_index do |row, index|
      print 8 - index, " "
      row.each do |square|
        print '|'
        if square.nil?
          print "_"
        else
          print square
        end
      end
      puts "| #{8 - index}"
    end
    puts "   " + ('a'..'h').to_a.join(' ')
  end

  def checkmate?(player1, player2)
    both_kings = @pieces.select { |piece| piece.is_a?(King) }
    player1_king = both_kings.select { |piece| piece.owner.color == :blue }[0]
    player2_king = both_kings.select { |piece| piece.owner.color == :red }[0]
    kings = [player1_king, player2_king]

    # if player1_king.in_check?
    #   escapes = player1_king.possible_destinations
    #   escapes.select! do |escape|
    #     player1_king.valid_move? escape
    #   end
    #
    #   escapes.reject! do |escape|
    #     original_location = player1_king.location
    #
    #     player1.make_move(player1_king, escape)
    #     result = player1_king.in_check?
    #
    #     player1.make_move(player1_king, original_location)
    #
    #     result
    #   end
    #
    #   return escapes.empty?
    # end


    kings.each do |king|
      if king.in_check?
        escapes = king.possible_destinations
        escapes.select! do |escape|
          king.valid_move? escape
        end

        escapes.reject! do |escape|
          original_location = king.location

          king.owner.make_move(king, escape)
          result = king.in_check?

          king.owner.make_move(king, original_location)

          result
        end

        return escapes.empty? if escapes.empty?
      end
    end


    false
  end

  def set_square_contents(coord, value)
    @board[coord[0]][coord[1]] = value
  end

  def get_square_contents(coord)
    @board[coord[0]][coord[1]]
  end

  def [](x, y)
    @board[x][y]
  end

  def []=(x, y, value)
    @board[x][y] = value
  end

  def empty_board
    Array.new(8) { Array.new(8) { nil } }
  end
end



