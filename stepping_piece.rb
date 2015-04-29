

class SteppingPiece < Piece # Knight: L-shaped
                            # King: 1 in any direction
  KNIGHT_DIRECTION = [[-2,1],[-2,-1],[2,1],[2,-1],[1,-2],[-1,-2],[1,2],[-1,-2]]
  KING_DIRECTION = [[1,0],[1,1],[1,-1],[0,1],[0,-1],[-1,1],[-1,0],[-1,-1]]

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

    return valid_moves if on_board?(next_move) == false    # If piece is in range of grid

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

end

class Knight < SteppingPiece
  def move_dirs
    all_valid_moves = []
    KNIGHT_DIRECTION.each do |direction|
       all_valid_moves += explore_direction(direction)
    end
    all_valid_moves
  end
end

class King < SteppingPiece
  def move_dirs
    all_valid_moves = []
    KING_DIRECTION.each do |direction|
       all_valid_moves += explore_direction(direction)
    end
    all_valid_moves
  end
end
