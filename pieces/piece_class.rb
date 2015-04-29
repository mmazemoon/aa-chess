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

  def moves
    @valid_moves = []
  end


end
