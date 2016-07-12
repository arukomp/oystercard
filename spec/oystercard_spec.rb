# This is the error: uninitialized constant Oystercard (NameError)
# This is the file path: /Users/acsauk/Projects/week_2/oystercard/spec/oystercard_spec.rb
# This is the line number of the error: 2
# The NameError has appeared because we have not told the spec file where to find the constant
# Create a constant/class called 'Oystercard' and link it in the spec file using require
require 'oystercard'

describe Oystercard do

  context 'when a new card is initialized' do
   it 'has a default balance of zero' do
     card = described_class.new
     expect(subject.balance).to eq(0)
   end
  end


  context 'when the card is topped up' do

    before do
      subject.top_up(described_class::MAX_LIMIT)
    end
    it 'raises an error when topping up above the limit' do
      message = "Maximum balance of #{described_class::MAX_LIMIT} reached"
      expect{ subject.top_up(1) }.to raise_error message
    end
    it 'allows to deduct money from the balance' do
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end

  end


  describe 'when a card is topped up' do
    it 'responds to top_up with one arugment' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'increases the balance on the card by the argument' do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
    end


  end

  describe '#in_journey?' do
    it 'returns false when first created' do
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it 'checks the card has a minimum balance' do
      message = "At least £#{described_class::MINIMUM_FARE} required"
      expect{ subject.touch_in }.to raise_error message
    end

    it 'is in journey after touching in' do
      subject.top_up(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'ends the journey after touching out' do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
