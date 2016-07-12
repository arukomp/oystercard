require "oystercard"
describe Oystercard do
  context "new card " do
    it "has default balance zero" do
      card = Oystercard.new
      expect(card.balance).to eq 0
    end
  end
end
