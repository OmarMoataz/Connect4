require_relative '../lib/Connect4'

describe Connect4 do
	subject(:connect4) {connect4 = Connect4.new}
	describe "#initialize" do 
		context "when initialized" do
			it "has a board instance variable" do
				expect(connect4.board).to be_an_instance_of(Board)
			end
			it "has a players enumerator" do
				expect(connect4.players.next).to be_an_instance_of(Player)
			end
		end
	end
end