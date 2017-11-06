class Board
	attr_accessor :grid
	def initialize
		@grid = Array.new(6) {Array.new(7)}
		set_initial_grid_values('-')
	end

	def set_initial_grid_values(character)
		(0..5).each do |row|
			(0..6).each do |col|
				@grid[row][col] = '-'
			end
		end
		return @grid
	end

	def get_top_most_row(col)
		5.downto(0).each do |row|
			return row if @grid[row][col] == '-'
		end
		return -1
	end

	def mark_cell(col, player_name)
		row = get_top_most_row(col)
		@grid[row][col] = player_name if row != -1
		return row
	end

	def check_winner
		return check_horizontal
	end

	private
	def check_vertical
	end

	def check_horizontal
		(0..5).each do |row|
			(0..3).each do |col|
				i = col 
				winner = true
				while(i <= col + 4) do
					winner = false if board.grid[row][i] != board.grid[row][col]
				end
				return board.grid[row][col] if winner == true
			end
		end
		return -1
	end

	def check_diagonal

	end
end