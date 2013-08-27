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


  def valid_move?(destination)
    return false if destination_same_owner? destination
    return false unless possible_destinations.include? destination

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

  def possible_destinations
    []


  end
end

class Pawn < Piece

end

class Rook < Piece
  def possible_destinations
    result = []

    (0..7).to_a.each_index do |i|
      result << [i, @location[1]]
      result << [@location[0], i]
    end

    result.reject { |destination| destination == @location }
  end
end

class Knight < Piece
  def possible_destinations
    moves = [
      [-2, -1],
      [-1, -2],
      [1, -2],
      [2, -1],
      [2, 1],
      [1, 2],
      [-1, 2],
      [-2, 1]
    ]

    moves.map do |move|
      [move[0] + @location[0], move[1] + @location[1]]
    end
  end
end

class Bishop < Piece

end

class Queen < Piece

end

class King < Piece

end