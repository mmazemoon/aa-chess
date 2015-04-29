
class Pawn < Piece
  KILLING_DIR = { white: [[-1,-1],[-1, 1]], black: [[1,-1], [1,1]]}
  NORMAL_DIR = { white: [[-1,0]], black: [[1,0]] }
  INITIAL_DIR = { white: [[-2,0]], black: [[2,0]] }

  def on_board?(position)
    row = position[0]
    col = position[1]
    if row >= 0 && row <= 7
      if col >= 0 && col <= 7
        return true
      end
    end
    false
  end

  def explore_direction(direction) #[-1,0]
    row = @position[0]
    col = @position[1]
    valid_moves = []
    n_row = direction[0]
    n_col = direction[1]
    next_move = [row + n_row, col + n_col]

    # If piece is in range of grid
    return valid_moves if on_board?(next_move) == false

    # If piece exists
    if !@board[*next_move].nil?
      return valid_moves
    else
      valid_moves << next_move
    end

    valid_moves
  end

  def explore_kill(direction)
    row = @position[0]
    col = @position[1]
    valid_moves = []
    n_row = direction[0]
    n_col = direction[1]
    next_move = [row + n_row, col + n_col]

    # If piece is in range of grid
    return valid_moves if on_board?(next_move) == false

    # If piece exists
    if !@board[*next_move].nil? && self.color == @board[*next_move].color
      return valid_moves
    elsif !@board[*next_move].nil? && self.color != @board[*next_move].color
      valid_moves << next_move
      return valid_moves
    end

    valid_moves
  end

  def move_dirs
    all_valid_moves = []

    if @moved == false
      total_dir = INITIAL_DIR[@color] + NORMAL_DIR[@color]
      total_dir.each do |direction|
        all_valid_moves += explore_direction(direction)
      end
    end

    if @moved == true
      NORMAL_DIR[@color].each do |direction|
        all_valid_moves += explore_direction(direction)
      end
    end

    KILLING_DIR[@color].each do |direction|
      all_valid_moves += explore_kill(direction)
    end

    all_valid_moves
  end
end

# King instance method
# def move_dirs
#   all_valid_moves = []
#   KING_DIRECTION.each do |direction|
#      all_valid_moves += explore_direction(direction)
#   end
#   all_valid_moves
# end
