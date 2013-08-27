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

  def collisions?(destination)
    if diagonal?(destination)

    else #not diagonal destination

    end
  end

  def diagonal?(destination)
    !(destination[0] == @location[0] || destination[1] == @location[1])
  end


  def diagonal_destinations
    result = []

    (0..7).to_a.each_index do |i|
      result << [i, @location[1]]
      result << [@location[0], i]
    end

    i = 0
    free = true
    current_location = self.location
    while current_location.all? {|coord| coord < 8 } && current_location.all? {|coord| coord < 8 } && free == true
      current_location[0] += 1
      current_location[0] += 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end

    i = 0
    free = true
    current_location = self.location
    while current_location.all? {|coord| coord < 8 } && current_location.all? {|coord| coord < 8 } && free == true
      current_location[0] += 1
      current_location[0] -= 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end

    i = 0
    free = true
    current_location = self.location
    while current_location.all? {|coord| coord < 8 } && current_location.all? {|coord| coord < 8 } && free == true
      current_location[0] -= 1
      current_location[0] += 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end

    i = 0
    free = true
    current_location = self.location
    while current_location.all? {|coord| coord < 8 } && current_location.all? {|coord| coord < 8 } && free == true
      current_location[0] -= 1
      current_location[0] -= 1
      result << [@location[0], i]
      free = false if get_square_contents(current_location)
    end
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
    # result = []
    #
    # (0..7).to_a.each_index do |i|
    #   result << [(@location[0] + i), (@location[1] + i)]
    #   result << [(@location[0] + i), (@location[1] - i)]
    #   result << [(@location[0] - i), (@location[1] - i)]
    #   result << [(@location[0] - i), (@location[1] + i)]
    # end
    #
    # result.reject { |destination| destination == @location }
    diagonal_destinations
  end
end

class Queen < Piece
  def possible_destinations
    result = []

    (0..7).to_a.each_index do |i|
      result << [(@location[0] + i), (@location[1] + i)]
      result << [(@location[0] + i), (@location[1] - i)]
      result << [(@location[0] - i), (@location[1] - i)]
      result << [(@location[0] - i), (@location[1] + i)]

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
    opponent_pieces = @board.pieces_on_board[other_color]
   # puts "checking these pieces: #{opponent_pieces}"
    in_check = opponent_pieces.any? do |piece|

      threatens_me? piece
    end
    p "in check" if in_check
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
      p "threatened by #{piece.class.to_s} of color #{piece.owner.color.to_s}"
      true
    end
  end

end

# b