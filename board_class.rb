require './pieces.rb'

class InvalidMoveError < StandardError; end

class Board
  attr_reader :grid

  def [](pos)
    row = pos[0]
    col = pos[1]
    @grid[row][col]
  end

  def []=(pos,piece)
    row = pos[0]
    col = pos[1]
    @grid[row][col] = piece
  end

  def dup_board
    result = Board.new(false)
  end

  def display
    @grid.each do |row|
      p row
    end
  end

  def initialize (pop = true)
    @grid = Array.new(8) {Array.new(8)}
    populate_board if pop
  end

  def in_check?(color)      # our king's position
                            # valid moves of all opponents pieces
    king_pos = find_king(color).position    # [x,y] == [x,y]
    opp_pieces = find_opp_pieces(color)
    opp_valid_pos = []

    opp_pieces.each { |piece| opp_valid_moves += piece.moves }
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

  def move(start,finish)
    piece = @grid[start]


      raise InvalidMoveError.new("my error message")
  end

  def move!(start,finish,piece)
    @grid[start] = nil
    @grid[finish] = piece
    piece.position = finish
  end

  def populate_board
    pop_pawns
    design = {black: 7, white: 0}
    design.each do |key, value|

      @grid[value] = @grid[value].map.with_index do |el, idx|
        if idx == 0 || idx == 7
          Rook.new(self,[value,idx], key, :R)
        elsif idx == 1 || idx == 6
          Knight.new(self,[value,idx], key, :N)
        elsif idx == 2 || idx == 5
          Bishop.new(self,[value,idx], key, :B)
        elsif idx == 3
          Queen.new(self,[value,idx], key, :Q)
        else
          King.new(self,[value,idx], key, :K)
        end
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
  p b
end

# holds piece?, index into array to return piece
