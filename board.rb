# frozen_string_literal:true

require 'erb'
load 'piece.rb'

# Define the Board
class Board
  attr_reader :square

  def initialize
    @square = Array.new(8) { Array.new(8, 0) }
    @gameover = false
    @turn_player = false
    setup

    until gameover?
      @turn_player = !@turn_player
      move
      to_html
    end

    puts @turn_player ? 'White Pieces Win' : 'Black Pieces Win'
  end

  def setup
    setup_pieces
    setup_pawns
    to_html
  end

  def setup_pawns
    setup_pawns_for_color(true, 1)
    setup_pawns_for_color(false, 6)
  end

  def setup_pawns_for_color(is_white, row)
    8.times do |index|
      piece = Pawn.new(is_white, [row, index])
      @square[row][index] = piece
    end
  end

  def setup_pieces
    setup_major_pieces(true, 1)
    setup_major_pieces(false, 6)
  end

  def setup_major_pieces(is_white, row)
    pieces = [Rook, Horse, Bishop, Queen, King, Bishop, Horse, Rook]

    pieces.each_with_index do |piece_class, index|
      @square[row][index] = piece_class.new(is_white, [row, index])
    end
  end

  def move
    valid = false
    until valid
      msg = gets.chomp
      if msg == 'ff'
        @turn_player = !turn_player
        return @gameover = true
      end
      valid = eval_move(msg)
    end
  end

  def eval_move(msg)
    move = msg.split('')
    move.pop if move[-1] == '+'
    return @gameover = true if move[-1] == '#'

    new_position = ['abcdefgh'.index(move[-2]), (move[-1].to_i - 1)]
    piece = 'RNBQK'.index(move[0])
    piece_move(piece, new_position, move)
  end

  def piece_move(piece, new_position, move)
    destination_piece = @square[new_position[0]][new_position[1]]
    return false if destination_piece.is_a?(Piece) && destination_piece.is_white == @turn_player

    move_handler = MoveHandler.new(self, piece, move, new_position, @turn_player)
    move_handler.perform_move
  end

  def gameover?
    @gameover
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

# class that handles the movement
class MoveHandler
  def initialize(board, piece, move, new_position, turn_player)
    @board = board
    @move = move
    @new_position = new_position
    @piece = piece
    @turn_player = turn_player

    select_piece
  end

  def select_piece
    piece_classes = [Rook, Horse, Bishop, Queen, King]
    possibilities = piece_classes[@piece]&.move(@new_position) || move_pawn
    @mover = filter_possibilities(possibilities)
  end

  def move_pawn
    possibilities = [[0, -1]] unless @move.contain?('x')
    possibilities = [[1, -1], [-1, -1]] if @move.contain?('x')
    @turn_player ? possibilities : -possibilities
  end

  def perform_move
    if double_move?
      perform_double_move
    elsif single_move?
      perform_single_move
    else
      false
    end
  end

  private

  def filter_possibilities(possibilities)
    possibilities.select do |possible|
      @board.square[possible[0]][possible[1]].is_a?(piece_class[@new_position])
    end
  end

  def perform_single_move
    source_position = @mover[0]
    destination_position = @new_position
    move_piece(source_position, destination_position)
  end

  def move_piece(source_position, destination_position)
    @board.square[destination_position[0]][destination_position[1]] =
      @board.square[source_position[0]][source_position[1]]
    @board.square[source_position[0]][source_position[1]] = ''
    true
  end
end
