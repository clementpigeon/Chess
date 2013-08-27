require 'colorize'

class Board

  def initialize
    #
  end

  def display
    puts "board".colorize :red
  end

  def checkmate?
    #
  end

  def [](x, y)
    board[x][y]
  end

  def []=(x, y, value)
    board[x][y] = value
  end


end


