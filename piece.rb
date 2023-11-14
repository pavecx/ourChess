# frozen_string_literal: true

# Class that defines a generic piece
class Piece
  attr_reader :url, :is_white

  def initialize(is_white, position)
    @is_white = is_white
    @url = 'https://upload.wikimedia.org/wikipedia/commons/4/45/Chess_plt45.svg'
    @url = 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Chess_pdt45.svg' unless is_white
    @dead = false
    @position = position
  end

  def valid_move?(move, delta)
    result = move.zip(delta).map { |m, d| m + d }
    result[0].between?(0, 7) && result[1].between?(0, 7)
  end

  def self.pawn_moves(move)
    possibilities = []

    # Define the possible directions for pawn moves based on color
    directions = @is_white ? [[-1, 0], [-2, 0] [-1, 1], [-1, -1]] : [[1, 0], [2, 0], [1, 1], [1, -1]]

    directions.each do |delta|
      possibilities.push(move.zip(delta).map { |m, d| m + d }) if valid_move?(move, delta)
    end

    possibilities
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

  def self.move(move)
    possibilities = []
    [-2, -1, 1, 2].each do |row|
      [-2, -1, 1, 2].each do |col|
        new_row = move[0] + row
        new_col = move[1] + col
        possibilities.push([new_row, new_col]) if (0..7).cover?(new_row) && (0..7).cover?(new_col)
      end
    end
    possibilities
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

  def valid_move?(move, delta)
    result = move.zip(delta).map { |m, d| m + d }
    result[0].between?(0, 7) && result[1].between?(0, 7)
  end

  def self.move(move)
    possibilities
    delta_values = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

    delta_values.each do |delta|
      possibilities.push(move.zip(delta).map { |m, d| m + d }) if valid_move?(move, delta)
    end

    possibilities
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

  def valid_move?(move, delta)
    result = move.zip(delta).map { |m, d| m + d }
    result[0].between?(0, 7) && result[1].between?(0, 7)
  end

  def self.move(move)
    possibilities = []
    delta_values = [[1, 0], [-1, 0], [0, -1], [0, 1]]

    delta_values.each do |delta|
      possibilities.push(move.zip(delta).map { |m, d| m + d }) if valid_move?(move, delta)
    end

    possibilities
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

  def valid_move?(move, delta)
    result = move.zip(delta).map { |m, d| m + d }
    result[0].between?(0, 7) && result[1].between?(0, 7)
  end

  def self.move(move)
    possibilities
    delta_values = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, -1], [0, 1]]

    delta_values.each do |delta|
      possibilities.push(move.zip(delta).map { |m, d| m + d }) if valid_move?(move, delta)
    end

    possibilities
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

  def valid_move?(move, delta)
    result = move + delta
    result[0].between?(0, 7) && result[1].between?(0, 7)
  end

  def self.move(move)
    possibilities
    delta_values = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, -1], [0, 1]]

    delta_values.each do |delta|
      possibilities.push(move + delta) if valid_move?(move, delta)
    end

    possibilities
  end
end
