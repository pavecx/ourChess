# frozen_string_literal:true

require 'erb'
load 'piece.rb'

# Define the Board
class Board
  def initialize
    @square = Array.new(8) { Array.new(8, 0) }
    setup_black
    setup_white
  end

  def setup_black
    @black_quenn_rook = Rook.new(false)
    @black_quenn_knight = Horse.new(false)
    @black_quenn_bishop = Bishop.new(false)
    @black_queen = Queen.new(false)
    @black_king = King.new(false)
    @black_king_bishop = Bishop.new(false)
    @black_king_knight = Horse.new(false)
    @black_king_rook = Rook.new(false)
    @square[0] = [@black_quenn_rook, @black_quenn_knight, @black_quenn_bishop, @black_queen,
                  @black_king, @black_king_bishop, @black_king_knight, @black_king_rook]
  end

  def setup_white
    @white_quenn_rook = Rook.new(true)
    @white_quenn_knight = Horse.new(true)
    @white_quenn_bishop = Bishop.new(true)
    @white_queen = Queen.new(true)
    @white_king = King.new(true)
    @white_king_bishop = Bishop.new(true)
    @white_king_knight = Horse.new(true)
    @white_king_rook = Rook.new(true)
    @square[7] = [@white_quenn_rook, @white_quenn_knight, @white_quenn_bishop, @white_queen,
                  @white_king, @white_king_bishop, @white_king_knight, @white_king_rook]
  end

  def to_html(piece)
    board_template = ERB.new File.read('board.erb')
    board = board_template.result(binding)

    filename = '/var/www/src/taichi/odin-recipes/Chess/index.html'

    File.open(filename, 'w') do |file|
      file.puts board
    end
    puts 'Board rendered'
  end
end
