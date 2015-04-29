require './pieces.rb'

class Board
  attr_reader :grid

  def [](row,col)
    @grid[row][col]
  end

  def []=(row,col,piece)
    @grid[row][col] = piece
  end

  def display
    @grid.each do |row|
      p row
    end
  end

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate_board
  end

  def in_check?(color)
    # our king's position
    # valid moves of all opponents pieces
    king_pos = find_king(color).position    # [x,y] == [x,y]
    opp_pieces = find_opp_pieces(color)
    opp_valid_pos = []

    opp_pieces.each { |piece| opp_valid_moves += piece.make_dirs }
    opp_valid_pos.include?(king_pos)    # [[1,2], [2,4]], [[3, 4], [4,5]]
  end

  def find_king(color)  #:white #black
    pieces = @grid.flatten.compact
    king = pieces.find do |piece|
      piece.is_a?(King) && piece.color == color
    end
  end

  def find_opp_pieces(color)
    pieces = @grid.flatten.compact
    pieces.reject {|piece| piece.color == color}
  end

  def populate_board
    pop_pawns

    @grid[0] = @grid[0].map.with_index do |el, idx|
      if idx == 0 || idx == 7
        Rook.new(self,[0,idx],:black, :R)
      elsif idx == 1 || idx == 6
        Knight.new(self,[0,idx],:black, :N)
      elsif idx == 2 || idx == 5
        Bishop.new(self,[0,idx],:black, :B)
      elsif idx == 3
        Queen.new(self,[0,idx],:black, :Q)
      else
        King.new(self,[0,idx],:black, :K)
      end
    end

    @grid[7] = @grid[7].map.with_index do |el, idx|
      if idx == 0 || idx == 7
        Rook.new(self,[7,idx],:white, :R)
      elsif idx == 1 || idx == 6
        Knight.new(self,[7,idx],:white, :N)
      elsif idx == 2 || idx == 5
        Bishop.new(self,[7,idx],:white, :B)
      elsif idx == 3
        Queen.new(self,[7,idx],:white, :Q)
      else
        King.new(self,[7,idx],:white, :K)
      end
    end
  end

  def pop_pawns
    @grid[1]= @grid[1].map.with_index do |el,idx|
      Pawn.new(self,[1,idx],:black, :p)
    end

    @grid[6]= @grid[6].map.with_index do |el,idx|
      Pawn.new(self,[6,idx],:white, :p)
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new

  char = Rook.new(b, [5,5], :white, :Q)
  b.display
  p char.move_dirs

end

# holds piece?, index into array to return piece
