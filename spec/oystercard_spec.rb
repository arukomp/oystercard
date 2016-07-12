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
    it "raises error if over max. balance" do
      maximum_balance = Oystercard::LIMIT
      card.top_up(maximum_balance)
      message = "card limit #{maximum_balance} exceeded"
      expect{card.top_up(1)}.to raise_error message
    end
    it "deducts fare from balance" do
      card.top_up(10)
      expect{card.deduct(5)}. to change{card.balance}. by(-5)
    end
  end

  context "using card to touch in and out" do
    it "shows if new card is in journey" do
      expect(card).not_to be_in_journey
    end

    it "is in a journey after touch in" do
      card.top_up(2)
      card.touch_in
      expect(card).to be_in_journey
    end

    it "is not in a journey after touch out" do
      card.top_up(2)
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it "raises an error if a card with insufficient balance is touched in" do
      card.top_up(0.5)
      expect{card.touch_in}.to raise_error "Insufficient balance"
    end


  end

end
