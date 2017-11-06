require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

class Connect4
	attr_reader :players, :board
	def initialize
		@board = Board.new
		@players = [Player.new('R'), Player.new('Y')]
	end

	def run_game
		player_index = 0
		while(board.check_winner == -1 && board.game_end == false)
			output_col_numbers
			display_board
			prompt_user_input
			input = gets.chomp
			current_player_name = players[player_index].name
			while(check_position_validity(input) == false || mark_cell(input, current_player_name) == -1)
				puts "position is invalid, please enter another one"
				input = gets.chomp
			end
			mark_cell(input, current_player_name)
			player_index = 1 - player_index
		end
	end
	private
	def display_board
		(0..5).each do |row|
			(0..6).each do |col|
				print "#{board.grid[row][col]} "
			end
			puts
		end
	end

	def check_position_validity(pos)
		return true if pos.to_s =~ /[1-6]/
		return false
	end

	def output_col_numbers
		print "1 2 3 4 5 6 7\n"
	end

	def prompt_user_input
		puts "Please enter the column you want"
	end

	
end