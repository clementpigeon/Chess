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
    return false if destination_same_owner? destination
    return false unless possible_destinations.include? destination
    true
  end

  def destination_same_owner?(destination)
    destination_square = @board.get_square_contents(destination)
    destination_square && destination_square.owner == self.owner
  end

  def to_s
    PIECES_DISPLAY[self.class.to_s].colorize owner.color
  end

end

class Pawn < Piece
  def possible_destinations
    result = []
    diagonals = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1],
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

    diagonals.select! do |destination|
      destination_contents = @board.get_square_contents(destination)

      destination_contents && destination_contents.owner != @owner
    end

    result += diagonals

  end

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
  def possible_destinations
    result = []

    (0..7).to_a.each_index do |i|
      result << [(location[0] + i) % 8, (@location[1] + i) % 8]
      result << [(location[0] + i) % 8, (@location[1] - i) % 8]
    end

    result.reject { |destination| destination == @location }
  end
end

class Queen < Piece
  def possible_destinations
    result = []

    (0..7).to_a.each_index do |i|
      result << [(location[0] + i) % 8, (@location[1] + i) % 8]
      result << [(location[0] + i) % 8, (@location[1] - i) % 8]
      result << [i, @location[1]]
      result << [@location[0], i]
    end

    result.reject { |destination| destination == @location }
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

  end
end