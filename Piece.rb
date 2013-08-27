class Piece

  PIECES_DISPLAY = {
    pawn: "P",
    rook: 'R',
    knight: 'K',
    bishop: 'B',
    king: '*',
    queen: 'Q'
  }

  attr_accessor :board, :type, :owner, :location

  def initialize (board, type, owner, location)
    @board, @type, @owner, @location = board, type, owner, location
  end

  def move(destination)
    #you better pass it a legal destination or else this will break
  end

  def valid_move?(destination)

  end

  def to_s
    PIECES_DISPLAY[self.type].colorize owner.color
  end



end