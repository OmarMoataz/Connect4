require_relative '../lib/board.rb'
require_relative 'helper.rb'

describe Board do
	subject(:board) {Board.new(6,7)}
	
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
		before(:each) {board = Board.new(6, 7)}
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
		describe "HORIZONTAL CASE" do
			context "when row has 4 elements with 'Y'" do
				it "first 4 elements, returns winner Y" do
					board.grid.fill_board_row(0, 'Y', 0, 3)
					board.display_grid
					expect(board.check_winner).to eql("Y")
				end

				it "last 4 elements, returns 'Y'" do
					board.grid.fill_board_row(0, 'Y', 3, 6)
					board.display_grid
					expect(board.check_winner).to eql("Y")
				end

				it "middle 4 elements, returns 'Y'" do
					board.grid.fill_board_row(0, 'Y', 2, 5)
					board.display_grid
					expect(board.check_winner).to eql("Y")
				end
			end

			context "when row has 3 elements with 'Y'" do
				it "returns '-1'" do
					board.grid.fill_board_row(1, 'Y', 0, 2)
					board.display_grid
					expect(board.check_winner).to eql(-1)
				end
			end

			context "when row has 1 element with 'Y'" do 
				it "returns '-1'" do
					board.grid.fill_board_col(0, 'Y', 0, 0)
					board.display_grid
					expect(board.check_winner).to eql(-1)
				end
			end

			context "when row has no elements with 'Y'" do
				it "returns -1" do
					board.display_grid
					expect(board.check_winner).to eql(-1)
				end
			end

			context "when row has mixed elements" do
				context "has 4 consec matching elements" do
					it "returns the element" do
						board.grid.fill_board_row(4, 'Y', 0, 3)
						board.grid.fill_board_row(4, 'R', 4, 6)
						board.display_grid
						expect(board.check_winner).to eql("Y")
					end
				end

				context "has < 4 consec matching elements" do
					it "returns -1" do
						board.grid.fill_board_row(3, 'R', 0, 2)
						board.grid.fill_board_row(3, 'Y', 3, 5)
						board.grid.fill_board_row(3, 'R', 6, 6)
						board.display_grid
						expect(board.check_winner).to eql(-1)
					end
				end
			end
		end

		describe "VERTICAL CASE" do
			context "when 4 consec matching elements" do
				it "returns the element" do
					board.grid.fill_board_col(0, 'Y', 0, 3)
					board.display_grid
					expect(board.check_winner).to eql('Y')
				end
			end

			context "when 3 consec matching elements" do
				it "returns -1" do
					board.grid.fill_board_col(0, 'Y', 0, 2)
					board.display_grid
					expect(board.check_winner).to eql(-1)
				end
			end

			context "when mixed elements" do
				context "< 4 consec matching elements" do
					it "returns -1" do
						board.grid.fill_board_col(0, 'Y', 0, 2)
						board.grid.fill_board_col(0, 'R', 3, 4)
						board.grid.fill_board_col(0, 'Y', 5, 5)
						board.display_grid
						expect(board.check_winner).to eql(-1)
					end
				end

				context ">= 4 consec matching elements" do
					it "returns element" do
						board.grid.fill_board_col(2, 'R', 2, 5)
						board.grid.fill_board_col(2, 'Y', 0, 1)
						board.display_grid
						expect(board.check_winner).to eql('R')
					end
				end
			end
		end

		describe "DIAGONAL CASE" do
			context "when >= 4 consec matching elements" do
				context "when mixed elements" do
					it "returns element" do
						board.grid.fill_board_diagonal(0, 0, 'R', 4)
						board.display_grid
						expect(board.check_winner).to eql('R')
					end
				end

				context "when elements of the same kind" do
					it "returns element" do
						board.grid.fill_board_diagonal(0,0,'Y', 3)
						board.grid.fill_board_diagonal(5,5, 'Y', 1)
						board.display_grid
						expect(board.check_winner).to eql('Y')
					end
				end
			end

			context "when < 4 consec matching elements" do
				context "when mixed elements" do
					it "returns -1" do
						board.grid.fill_board_diagonal(0, 0, 'R', 2)
						board.grid.fill_board_diagonal(4, 4, 'Y', 2)
						board.display_grid
						expect(board.check_winner).to eql(-1)
					end
				end

				context "when elements of the same kind" do
					it "returns -1" do
						board.grid.fill_board_diagonal(0,0,'Y', 2)
						board.display_grid
						expect(board.check_winner).to eql(-1)
					end
				end
			end
		end
	end
end
