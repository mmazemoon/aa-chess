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

  def explore_direction(direction)
    row = @position[0]
    column = @position[1]
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
    else
      valid_moves << next_move
    end

    valid_moves
  end

  def explore_kill(direction)
    row = @position[0]
    column = @position[1]
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

    if @moved == false && @color == :white
      total_dir = INITIAL_DIR[:white] + NORMAL_DIR[:white]
      total_dir.each do |direction|
        all_valid_moves += explore_direction(direction)
      end
    end

    if @moved == false && @color == :black
      total_dir = INITIAL_DIR[:black] + NORMAL_DIR[:black]
      total_dir.each do |direction|
        all_valid_moves += explore_direction(direction)
      end
    end

    if @moved == true && @color == :black
      NORMAL_DIR[:black].each do |direction|
        all_valid_moves += explore_direction(direction)
    elsif @moved == true && @color == :white
      NORMAL_DIR[:white].each do |direction|
        all_valid_moves += explore_direction(direction)
      end
    end

    if @color == :black
      KILLING_DIR[:black].each do |direction|
        all_valid_moves += explore_direction(direction)
    elsif @color == :white
      KILLING_DIR[:white].each do |direction|
        all_valid_moves += explore_direction(direction)
      end
    end
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
