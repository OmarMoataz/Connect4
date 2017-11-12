require_relative '../lib/board.rb'

class Array
	def fill_board_col(col, player_name, start, ender)
		i = start
		while(i <= ender) do
			self[5 - i][col] = player_name
			i += 1
		end
	end

	def fill_board_row(row, player_name, start, ender)
		i = start
		while(i <= ender) do
			self[row][i] = player_name
			i += 1
		end
	end

	def fill_board_diagonal(row, col, player_name, range)
		i,j = row, col
		while(i <= range)
			self[i][j] = player_name
			i += 1
			j += 1
		end
	end
end