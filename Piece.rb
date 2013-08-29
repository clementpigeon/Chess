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
    return false if not is_on_board?(destination)
    return false if destination_same_owner? destination
   # return false if moving_into_check? destination
    true
  end

  def valid_destinations
    possible_destinations.select do |destination|
   #   puts "checking validity of moving #{self.class} at #{@location} to #{destination}"
      valid_move? destination
    end
  end

  def moving_into_check?(destination)
    original_location = @location.dup

    if @board[destination[0], destination[1]]
      destination_content = @board[destination[0], destination[1]].dup
    end

    @owner.make_move(self, destination)

    result = @owner.king.in_check?

    @owner.make_move(self, original_location)

    if @board[destination[0], destination[1]]
      @board[destination[0], destination[1]] = destination_content
    end

    result
    false
  end

  def destination_same_owner?(destination)
    destination_square = @board.get_square_contents(destination)
    destination_square && destination_square.owner == self.owner
  end

  def to_s
    PIECES_DISPLAY[self.class.to_s].colorize owner.color
  end

  def iterate_destinations(directions)
    result = []
    directions.each do |direction|
      i = 0
      free = true
      current_location = self.location.dup if @location

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

  def is_on_board?(square)
    square.all? { |coord| coord.between?(0,7) }
  end

  def other_color
    if @owner.color == :red
      return :blue
    else
      return :red
    end
  end
end

class Pawn < Piece
  def possible_destinations
    return [] unless @location

    result = []

    row = @location[0]
    col = @location[1]

    result << [row - 1, col ] if @owner.color == :blue
    result << [row + 1, col ] if @owner.color == :red

    result << [row - 2, col ] if @owner.color == :blue && @location[0] == 6
    result << [row + 2, col ] if @owner.color == :red && @location[0] == 1

    result.reject! do |destination|
      square_occuppied_by_other_color?(destination)
    end

    blue_diagonals = [     # player 1 = blue goes up
      [-1, -1],
      [-1, 1]
      ]

    red_diagonals = [      # player 2 = red goes down
      [1, -1],
      [1, 1]
    ]

    blue_diagonals.each do |move|
      destination = [ move[0] + @location[0], move[1] + @location[1] ]
      if square_occuppied_by_other_color?(destination)
        result << destination
      end
    end

    red_diagonals.each do |move|
      destination = [ move[0] + @location[0], move[1] + @location[1] ]
      if square_occuppied_by_other_color?(destination)
        result << destination
      end
    end

    result



    # diagonals.map! do |move|
   #    [move[0] + @location[0], move[1] + @location[1]]
   #  end
   #
   #  if @owner.color == :blue # player 1 pawn only goes up
   #    next_square = @board.get_square_contents([@location[0] - 1, @location[1]])
   #    result << [@location[0] - 1, @location[1]] if next_square.nil?
   #    diagonals = diagonals[0..1]
   #  else # player 2 pawn only goes down
   #    next_square = @board.get_square_contents([@location[0] + 1, @location[1]])
   #    result << [@location[0] + 1, @location[1]] if next_square.nil?
   #    diagonals = diagonals[2..3]
   #  end



#
#     if @owner.color == :blue && @location[0] == 6  # player 1 pawn only goes up
#       next_square = @board.get_square_contents([@location[0] - 2, @location[1]])
#       result << [@location[0] - 2, @location[1]] if next_square.nil?
#       diagonals = diagonals[0..1]
#     elsif @location[0] == 1 # player 2 pawn only goes down
#       next_square = @board.get_square_contents([@location[0] + 2, @location[1]])
#       result << [@location[0] + 2, @location[1]] if next_square.nil?
#       diagonals = diagonals[2..3]
#     end
#
#     diagonals.select! do |destination|
#       destination_contents = @board.get_square_contents(destination)
#
#       destination_contents && destination_contents.owner != @owner
#     end
#
#     result += diagonals

  end

  def square_occuppied_by_other_color?(square)
    return false if not is_on_board?(square)
    return false if not @board.get_square_contents(square)
    return false if not @board.get_square_contents(square).owner.color == self.other_color
    true
  end

end

class Rook < Piece
  def possible_destinations
    return [] unless @location

    vertical_destinations
  end
end

class Knight < Piece
  def possible_destinations
    return [] unless @location

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

    moves.map! do |move|
      [move[0] + @location[0], move[1] + @location[1]]
    end
   # moves.select! { |destination| valid_move? destination }
  end
end

class Bishop < Piece
  def possible_destinations
    return [] unless @location

    diagonal_destinations
  end
end

class Queen < Piece
  def possible_destinations
    return [] unless @location

    vertical_destinations + diagonal_destinations
  end
end

class King < Piece
  def possible_destinations
    return [] unless @location

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
    opponent_pieces = @board.pieces.select do |piece|
      piece.owner.color == other_color && piece.location
    end
    opponent_pieces.reject! { |piece| piece.is_a?(King) }
    in_check = opponent_pieces.any? do |piece|
      threatens_me? piece
    end
  end

  def threatens_me?(piece)
    if piece.valid_destinations.include? @location
      true
    end
  end

end
