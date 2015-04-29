class Pawn < Piece
  KILLING_DIR = { white: [[-1,-1],[-1, 1]], black: [[1,-1], [1,1]]}
  NORMAL_DIR = { white: [[-1,0]], black: [[1,0]] }
  INITIAL_DIR = { white: [[-2,0]], black: [[2,0]] }

  def explore_direction(direction)

  end

  def move_dirs
    all_valid_moves = []

    if @moved == false && @color == :white
      total = INITIAL_DIR[:white] + NORMAL_DIR[:white]
       total.each do |direction|
         all_valid_moves += explore_direction(direction)
    end

    if @moved == false && @color == :black


    BISHOP_DIRECTION.each do |direction|
       all_valid_moves += explore_direction(direction)
    end
    all_valid_moves
  end

end
