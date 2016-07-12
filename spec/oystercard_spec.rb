require "oystercard"
describe Oystercard do
  subject(:card){described_class.new}
  context "new card " do
    it "has default balance zero" do
      expect(card.balance).to eq 0
    end
  end

  context "changing balance" do
    it "tops up balance" do
      expect{card.top_up(5)}.to change{card.balance}.by(5) 
    end
  end
end
