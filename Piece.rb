class Piece

  attr_accessor :board, :type, :owner, :location

  def initialize (board, type, owner, location)
    @board, @type, @owner, @location = board, type, owner, location
  end

  def move(destination)
    #you better pass it a legal destination or else this will break
  end

  def valid_move?(destination)

  end

end