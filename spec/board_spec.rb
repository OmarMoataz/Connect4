require_relative '../lib/board.rb'
require_relative 'helper.rb'

describe Board do
	subject(:board) {Board.new}
	
	describe "#initialize" do
		context "has an empty 6*7 row array" do
			it "has 6 rows" do
				expect(board.grid.length).to eql(6)
			end
			it "has 7 columns in every row" do
				board.grid.all? {|row| row.length == 7}
			end
		end
	end

	describe "#set_initial_grid_values(char)" do
		context "when sent char '-'" do
			before(:each) {board.set_initial_grid_values('-')}
			it "sets @grid[0][0] to '-'" do
				expect(board.grid[0][0]).to eql('-')
			end
			it "sets the @grid[5][6] to '-'" do
				expect(board.grid[5][6]).to eql('-')
			end
		end
	end

	describe "#mark_cell (col, player_name)" do
		before(:each) {board = Board.new}
		context "when given col '6', empty" do
			it "sets board[5][6] to 'R'" do
				board.mark_cell(6,'R')
				expect(board.grid[5][6]).to eql('R')
			end
		end

		context "when given col '6', partially full (1 element)" do
			it "sets board[4][6] to 'R'" do
				upper_row = nil
				2.times do
					upper_row = board.mark_cell(6,'R')
				end
				expect(board.grid[upper_row][6]).to eql('R')
			end
		end

		context "when given col '1', partially full (2 elements)" do
			it "sets the value [3][1] to 'R'" do
				returned_row = nil
				3.times do
					returned_row = board.mark_cell(1,'R')
				end
				expect(board.grid[returned_row][1]).to eql('R')
			end
		end

		context "when given col '1', partially full (2 elements)" do
			it "doesn't set any values, returns -1" do
				6.times {board.mark_cell(1,'R')}
				expect(board.mark_cell(1, 'R')).to eql(-1)
			end
		end
	end

	describe "#check_winner" do
		context "check horizontal case" do
			context "when row has 4 elements with 'Y'" do
				it "first 4 elements, returns winner Y" do
					# board.grid.fill_board_row(0, 'Y', 0, 3)
					expect(board.check_winner).to eql("Y")
				end

				it "last 4 elements, returns 'Y'" do
					# board.grid.fill_board_row(0, 'Y', 3, 6)
					expect(board.check_winner).to eql("Y")
				end

				it "middle 4 elements, returns 'Y'" do
					board.grid.fill_board_row(0, 'Y', 2, 5)
					expect(board.check_winner).to eql("Y")
				end
			end

			context "when row has 3 elements with 'Y'" do
				it "returns '-1'" do
					# board.grid.fill_board_row(1, 'Y', 0, 2)
					expect(board.check_winner).to eql(-1)
				end
			end
		end
	end
end
