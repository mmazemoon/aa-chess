require './pieces.rb'

class Piece
  attr_reader :color
  attr_accessor :role, :position

  def initialize(board,position,color,role)
    @board = board
    @position = position
    @color = color
    @role = role
    @moved = false
  end

  def inspect
    @role.to_sym
  end

  def valid_moves
    valid_moves = moves.reject do |next_move|
      move_into_check?(next_move)
      # the ones that dont put me in check
    end
  end

  def move_into_check?(next_move)
  end

  def dup_pieces(board_copy)
     pieces = @board.flatten.compact

     pieces.each do |obj|
      pc = Piece.new(board_copy, obj.position, obj.color, obj.role)
      board_copy[obj.position] = pc
    end
    board_copy
  end

  # def moves
  #   raise NotImplementedError
  # end
end
