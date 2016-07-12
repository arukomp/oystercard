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

  describe 'when a card is topped up' do
    it 'responds to top_up with one arugment' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'increases the balance on the card by the argument' do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it 'raises an error when topping up above the limit' do
      subject.top_up(described_class::MAX_LIMIT)
      message = "Maximum balance of #{described_class::MAX_LIMIT} reached"
      expect{ subject.top_up(1) }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'deducts money from balance' do
      subject.top_up(10)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

end
