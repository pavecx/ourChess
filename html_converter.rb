# frozen_string_literal:true

require 'erb'

def to_html(piece)
  board_template = ERB.new File.read('board.erb')
  board = board_template.result(binding)

  filename = '/var/www/src/taichi/odin-recipes/Chess/index.html'

  File.open(filename, 'w') do |file|
    file.puts board
  end
  puts 'Board rendered'
end
