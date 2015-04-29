class SlidingPiece < Piece      # bishop, rook, queen -
                                # traverse as many spaces as availabe
  ROOK_DIRECTION =[[0,1], [-1, 0], [1, 0], [0, -1]]
  BISHOP_DIRECTION = [[1,1], [-1,1], [-1,-1], [1,-1]]
  QUEEN_DIRECTION = ROOK_DIRECTION + BISHOP_DIRECTION

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

    loop do
      break if on_board?(next_move) == false    # If piece is in range of grid

      # If piece exists
      if !@board[*next_move].nil? && self.color == @board[*next_move].color
        break
      elsif !@board[*next_move].nil? && self.color != @board[*next_move].color
        valid_moves << next_move
        break
      else
        valid_moves << next_move
      end
      next_move = [next_move[0] + n_row, next_move[1] + n_col]
    end
    valid_moves
  end

end

class Bishop < SlidingPiece

  def move_dirs
    all_valid_moves = []
    BISHOP_DIRECTION.each do |direction|
       all_valid_moves += explore_direction(direction)
    end
    all_valid_moves
  end

end


class Rook < SlidingPiece

  def move_dirs
    all_valid_moves = []
    ROOK_DIRECTION.each do |direction|
       all_valid_moves += explore_direction(direction)
    end
    all_valid_moves
  end

end

class Queen < SlidingPiece

  def move_dirs
    all_valid_moves = []
    QUEEN_DIRECTION.each do |direction|
       all_valid_moves += explore_direction(direction)
    end
    all_valid_moves
  end

end







# From: Rook class
#
# def left
#
#   row = @position[0]
#   col = @position[1]
#   result = []
#
#   until col < 0
#       col -= 1
#       result << [row,col]
#   end
#   result
# end
#
# def right
#
#   row = @position[0]
#   col = @position[1]
#   result = []
#
#   until col > 7
#       col += 1
#       # check @board[row, col]
#       result << [row,col]
#   end
#   result
# end
#
# def up
#   row = @position[0]
#   col = @position[1]
#   result = []
#
#   until row < 0
#       row -= 1
#       result << [row,col]
#   end
#   result
# end
#
# def down
#   row = @position[0]
#   col = @position[1]
#   result = []
#
#   until row > 7
#       row += 1
#       result << [row,col]
#   end
#   result
# end
