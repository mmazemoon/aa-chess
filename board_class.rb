class Board

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def populate_board
    Piece.new(self,[3,4],:black)
  end

end


piece or nil

# holds piece?, index into array to return piece
