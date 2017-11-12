class Board
	attr_accessor :grid
	attr_reader :rows, :cols
	def initialize(rows, cols)
		@rows = rows
		@cols = cols
		@grid = Array.new(rows) {Array.new(cols)}
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
		(5).downto(0) do |row|
			return row if  @grid[row][col] == '-'
		end
		return -1
	end

	def mark_cell(col, player_name)
		row = get_top_most_row(col)
		@grid[row][col] = player_name if row != -1
		return row
	end

	def check_winner
		ret_vertical = check_vertical
		ret_horizontal = check_horizontal
		if ret_vertical != -1
			return ret_vertical
		elsif ret_horizontal != -1
			return ret_horizontal
		else
			return -1
		end

	end

	def display_grid
		for i in (0..5) do
			for j in (0..6) do
				print "#{@grid[i][j]} "
			end
			puts
		end
	end

	def game_end
		(0..5).each do |row|
			(0..6).each do |col|
				return false if @grid[row][col] == '-'
			end
		end
		return true
	end

	private
	def player_selected_cell(row, col)
		return true if @grid[row][col] =~ /[YR]/
		return false
	end

	def valid(row, col)
		return true if row < @rows && row >= 0 && col < @cols && col >= 0
		return false
	end

	def check4_consecutive(ref_row, ref_col, row_iteration, col_iteration)
		i, j = ref_row, ref_col
		winner = true
		(0..3).each do
			winner = false if !valid(ref_row, ref_col) || @grid[i][j] != @grid[ref_row][ref_col]
			i += row_iteration
			j += col_iteration
		end
		return winner
	end

	def check_vertical
		(0..6).each do |col|
			(0..2).each do |row|
				if player_selected_cell(row, col)
					winner = check4_consecutive(row, col, 1, 0)
					return @grid[row][col] if winner == true
				end
			end
		end
		return -1
	end

	def check_horizontal
		(0..5).each do |row|
			(0..3).each do |col|
				if player_selected_cell(row, col)
					winner = check4_consecutive(row, col, 0, 1)
					return @grid[row][col] if winner == true
				end
			end
		end
		return -1
	end

	def upward(row, col)
		while(row >= 0 && col < @cols) do
			return @grid[row][col] if check4_consecutive(row, col, -1, 1) == true
			row -= 1
			col += 1
		end
		return -1
	end

	def downward(row, col)
		while(row < @rows && col < @cols) do
			return @grid[row][col] if check4_consecutive(row, col, 1, 1) == true
			row += 1
			col += 1
		end
		return -1
	end

	def check_diagonal
		(0..@rows - 4).each {|row| return downward(row, 0) if downward(row, 0) != -1}
		(0..@cols - 4).each {|col| return downward(0, col) if downward(0, col) != -1}
		(@rows - 3..@rows - 1).each {|row| return upward(row, 0) if upward(row, 0) != -1}
		(@cols - 3..@cols - 1).each {|col| return upward(5, col) if upward(5, col) != -1}
		return -1
	end

	
end