# frozen_string_literal: true

# Class that defines a generic piece
class Piece
  attr_reader :url

  def initialize(is_white)
    @is_white = is_white
    @url = ' '
    @dead = false
    @move_set = [[1, 1]]
    @position = [1, 1]
  end

  def valid?(move)
    @move_set.include(move)
  end
end

# Class that defines the Horsey boy piece
class Horse < Piece
  def initialize(is_white, position)
    super(is_white, position)
    @url = 'https://upload.wikimedia.org/wikipedia/commons/7/70/Chess_nlt45.svg'
    @url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Chess_ndt45.svg' unless @is_white
    @position = position
  end
end

# Class that defines the Bishy buddy piece
class Bishop < Piece
  def initialize(is_white, position)
    super(is_white, position)
    @url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Chess_blt45.svg'
    @url = 'https://upload.wikimedia.org/wikipedia/commons/9/98/Chess_bdt45.svg' unless @is_white
    @position = position
  end
end

# Class that defines the Rookie piece
class Rook < Piece
  def initialize(is_white, position)
    super(is_white, position)
    @url = 'https://upload.wikimedia.org/wikipedia/commons/7/72/Chess_rlt45.svg'
    @url = 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Chess_rdt45.svg' unless @is_white
    @position = position
  end
end

# Class that defines the Poki piece
class Queen < Piece
  def initialize(is_white, position)
    super(is_white, position)
    @url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Chess_qlt45.svg'
    @url = 'https://upload.wikimedia.org/wikipedia/commons/4/47/Chess_qdt45.svg' unless @is_white
    @position = position
  end
end

# Class that defines the King piece
class King < Piece
  def initialize(is_white, position)
    super(is_white, position)
    @url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Chess_klt45.svg'
    @url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Chess_kdt45.svg' unless @is_white
    @position = position
  end
end
