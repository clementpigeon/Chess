class Piece

  PIECES_DISPLAY = {
    'Pawn' => "P",
    'Rook' => 'R',
    'Knight' => 'K',
    'Bishop' => 'B',
    'King' => '*',
    'Queen' => 'Q'
  }

  attr_accessor :board, :owner, :location

  def initialize (board, owner, location)
    @board, @owner, @location = board, owner, location
  end

  def valid_move?(destination)
    return false unless destination.all? { |coord| coord.between?(0,7) }
    return false if destination_same_owner? destination
    return false unless possible_destinations.include? destination
    true
  end

  def destination_same_owner?(destination)
    destination_square = @board.get_square_contents(destination)
    destination_square && destination_square.owner == self.owner
  end

  def valid_destinations
    possible_destinations.select { |destination| valid_move? destination }
  end

  def to_s
    PIECES_DISPLAY[self.class.to_s].colorize owner.color
  end

  def iterate_destinations(directions)
    result = []
    directions.each do |direction|
      i = 0
      free = true
      current_location = self.location.dup

      while free == true
        current_location[0] += direction[0]
        current_location[1] += direction[1]
        if !current_location.all? { |coord| coord.between?(0,7) }
          free = false
        else
          result << [current_location[0], current_location[1]]
          free = false if @board.get_square_contents(current_location)
        end
      end
    end
    result
  end

  def diagonal_destinations
    directions = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]
    iterate_destinations(directions)
  end

  def vertical_destinations
    directions = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1]
    ]
    iterate_destinations(directions)
  end

end

class Pawn < Piece
  def possible_destinations
    result = []
    diagonals = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]

    diagonals.map! do |move|
      [move[0] + @location[0], move[1] + @location[1]]
    end

    if @owner.color == :blue # player 1 pawn only goes up
      next_square = @board.get_square_contents([@location[0] - 1, @location[1]])
      result << [@location[0] - 1, @location[1]] if next_square.nil?
      diagonals = diagonals[0..1]
    else # player 2 pawn only goes down
      next_square = @board.get_square_contents([@location[0] + 1, @location[1]])
      result << [@location[0] + 1, @location[1]] if next_square.nil?
      diagonals = diagonals[2..3]
    end

    if @owner.color == :blue && @location[0] == 6  # player 1 pawn only goes up
      next_square = @board.get_square_contents([@location[0] - 2, @location[1]])
      result << [@location[0] - 2, @location[1]] if next_square.nil?
      diagonals = diagonals[0..1]
    elsif @location[0] == 1 # player 2 pawn only goes down
      next_square = @board.get_square_contents([@location[0] + 2, @location[1]])
      result << [@location[0] + 2, @location[1]] if next_square.nil?
      diagonals = diagonals[2..3]
    end

    diagonals.select! do |destination|
      destination_contents = @board.get_square_contents(destination)

      destination_contents && destination_contents.owner != @owner
    end

    result += diagonals

  end

end

class Rook < Piece
  def possible_destinations
    vertical_destinations
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
  def possible_destinations
    diagonal_destinations
  end
end

class Queen < Piece
  def possible_destinations
    vertical_destinations + diagonal_destinations
  end
end

class King < Piece
  def possible_destinations
    moves = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]

    moves.map do |move|
      [move[0] + @location[0], move[1] + @location[1]]
    end
  end

  def in_check?
    opponent_pieces = @board.pieces.select { |piece| piece.owner.color == other_color }
    in_check = opponent_pieces.any? do |piece|
      threatens_me? piece
    end
    p "Check!" if in_check
    in_check
  end

  def other_color
    if @owner.color == :red
      return :blue
    else
      return :red
    end
  end

  def threatens_me?(piece)
    if piece.possible_destinations.include? @location
 #     p "threatened by #{piece.class.to_s} of color #{piece.owner.color.to_s}"
      true
    end
  end

end
