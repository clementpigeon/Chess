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
    return false if destination_same_owner? destination
    true

    #check if destination is within piece's viable move set
  end

  def destination_same_owner?(destination)
    destination_square = @board.get_square_contents(destination)
    destination_square && destination_square.owner == self.owner
  end

  def to_s
    PIECES_DISPLAY[self.type].colorize owner.color
  end


end