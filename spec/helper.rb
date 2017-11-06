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
			fill_board_col(i, player_name, 0, row)
			i += 1
		end
	end
end