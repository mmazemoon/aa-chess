require './pieces.rb'

class Board
  attr_reader :grid


  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate_board
  end

  def display
    @grid.each do |row|
      p row
    end
  end

  def [](row,col)
    @grid[row][col]
  end

  def []=(row,col,piece)
    @grid[row][col] = piece
  end

  def populate_board
    pop_pawns


      @grid[0] = @grid[0].map.with_index do |el, idx|
        if idx == 0 || idx == 7
          Rook.new(self,[0,idx],:black, :R).role
        elsif idx == 1 || idx == 6
          Knight.new(self,[0,idx],:black, :N).role
        elsif idx == 2 || idx == 5
          Bishop.new(self,[0,idx],:black, :B).role
        elsif idx == 3
          Queen.new(self,[0,idx],:black, :Q).role
        else
          King.new(self,[0,idx],:black, :Q).role
        end
      end

      @grid[7] = @grid[7].map.with_index do |el, idx|
        if idx == 0 || idx == 7
          Rook.new(self,[7,idx],:white, :R).role
        elsif idx == 1 || idx == 6
          Knight.new(self,[7,idx],:white, :N).role
        elsif idx == 2 || idx == 5
          Bishop.new(self,[7,idx],:white, :B).role
        elsif idx == 3
          Queen.new(self,[7,idx],:white, :Q).role
        else
          King.new(self,[7,idx],:white, :Q).role
        end
      end

  end

  def pop_pawns
    @grid[1]= @grid[1].map.with_index do |el,idx|
      Pawn.new(self,[1,idx],:black, :p).role
    end

    @grid[6]= @grid[6].map.with_index do |el,idx|
      Pawn.new(self,[6,idx],:white, :p).role
    end
  end



end

if __FILE__ == $PROGRAM_NAME
  board = Board.new

  plato = Pawn.new(board, [5,3], :white, :p)
  p plato.move_dirs
  p plato.position
end

# holds piece?, index into array to return piece
