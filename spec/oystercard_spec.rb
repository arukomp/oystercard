require "oystercard"
describe Oystercard do
  subject(:card){ described_class.new }
  let(:station) { double(:station) }

  context "new card " do
    it "has default balance zero" do
      expect(card.balance).to eq 0
    end

    it "has an empty journey history" do
      expect(card.journeys).to eq []
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

  end

  context "using card to touch in and out" do

    it "shows if new card is in journey" do
      expect(card).not_to be_in_journey
    end

    describe "when touching in and out" do
      before (:each) do
        card.top_up(Oystercard::MINIMUM_FARE)
        card.touch_in(station)
      end

      it "is in a journey after touch in" do
        expect(card).to be_in_journey
      end

      it "is not in a journey after touch out" do
        card.touch_out(station)
        expect(card).not_to be_in_journey
      end

      it "deducts the minimum fare for a journey on touch out" do
        expect{card.touch_out(station)}.to change {card.balance}.by (-Oystercard::MINIMUM_FARE)
      end

      it "remembers the touch in station" do
        expect(card.entry_station).to eq station
      end

      it "remembers the touch out station" do
        card.touch_out(station)
        expect(card.exit_station).to eq station
      end

    end # end describe

    describe "recording journey history" do

      before (:each) do
        card.top_up(Oystercard::MINIMUM_FARE)
        card.touch_in(station)
        card.touch_out(station)
      end

      it "stores a list of journeys" do
        expect(card.journeys.length).to eq 1
      end
    end

    it "raises an error if a card with insufficient balance is touched in" do
      card.top_up (Oystercard::MINIMUM_FARE - 1)
      message = "Insufficient balance. Minimum £#{Oystercard::MINIMUM_FARE} is required"
      expect{card.touch_in(station)}.to raise_error message
    end

  end # end context

end # end describe
