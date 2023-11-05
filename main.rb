# frozen_string_literal:true

load 'html_converter.rb'

board = Board.new

horse = 'https://upload.wikimedia.org/wikipedia/commons/7/70/Chess_nlt45.svg'

board.to_html(horse)
