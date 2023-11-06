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
    @black_quenn_rook = Rook.new(false, [0, 0])
    @black_quenn_knight = Horse.new(false, [0, 1])
    @black_quenn_bishop = Bishop.new(false, [0, 2])
    @black_queen = Queen.new(false, [0, 3])
    @black_king = King.new(false, [0, 4])
    @black_king_bishop = Bishop.new(false, [0, 5])
    @black_king_knight = Horse.new(false, [0, 6])
    @black_king_rook = Rook.new(false, [0, 7])
    @square[0] = [@black_quenn_rook, @black_quenn_knight, @black_quenn_bishop, @black_queen,
                  @black_king, @black_king_bishop, @black_king_knight, @black_king_rook]
  end

  def setup_white
    @white_quenn_rook = Rook.new(true, [7, 0])
    @white_quenn_knight = Horse.new(true, [7, 1])
    @white_quenn_bishop = Bishop.new(true, [7, 2])
    @white_queen = Queen.new(true, [7, 3])
    @white_king = King.new(true, [7, 4])
    @white_king_bishop = Bishop.new(true, [7, 5])
    @white_king_knight = Horse.new(true, [7, 6])
    @white_king_rook = Rook.new(true, [7, 7])
    @square[7] = [@white_quenn_rook, @white_quenn_knight, @white_quenn_bishop, @white_queen,
                  @white_king, @white_king_bishop, @white_king_knight, @white_king_rook]
  end

  def input(msg)
    move = msg.split('')
    move.pop if move[-1] == '+'
    return gameover if move[-1] == '#'

    new_position = ['abcdefgh'.find_index(move[-2]), (move[-1].to_i - 1)]
  end

  def to_html
    board_template = ERB.new File.read('board.erb')
    board = board_template.result(binding)

    filename = '/var/www/src/taichi/odin-recipes/Chess/index.html'

    File.open(filename, 'w') do |file|
      file.puts board
    end
    puts 'Board rendered'
  end
end
