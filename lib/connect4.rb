require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

class Connect4
	attr_reader :players, :board
	def initialize
		@board = Board.new(6,7)
		@players = [Player.new('R'), Player.new('Y')]
	end

	def run_game
		player_index = 0
		while(board.check_winner == -1 && board.game_end == false)
			output_col_numbers
			board.display_grid
			prompt_user_input
			input = gets.chomp
			current_player_name = players[player_index].name
			while(check_position_validity(input) == false ||board.mark_cell(input.to_i - 1, current_player_name) == -1)
				puts "position is invalid, please enter another one"
				input = gets.chomp
			end
			player_index = 1 - player_index
		end
	end
	private

	def check_position_validity(pos)
		return true if pos.to_s =~ /[1-7]/
		return false
	end

	def output_col_numbers
		print "1 2 3 4 5 6 7\n"
	end

	def prompt_user_input
		puts "Please enter the column you want"
	end
end

c4 = Connect4.new
c4.run_game