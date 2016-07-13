require 'oystercard'

describe Oystercard do
min_fare = Oystercard::MINFARE
let(:entry_station) {double('entry_station')}

  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end

  it 'in_journey returns false initially' do
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    it 'can touch_in' do
      subject.top_up(min_fare)
      subject.touch_in entry_station
      expect(subject).to be_in_journey
    end

    context 'balance below minimum fare' do
      it 'raises error if balance is less than minimum fare' do
        expect{subject.touch_in entry_station}.to raise_error "balance too low"
      end
    end
    it 'stores entery station' do
      subject.top_up min_fare
      subject.touch_in entry_station
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'deducts the fare when we touch out' do
      subject.top_up(min_fare)
      subject.touch_in entry_station
      expect{subject.touch_out}.to change {subject.balance}.by -min_fare
    end
    it 'can touch out' do
      subject.top_up(min_fare)
      subject.touch_in entry_station
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
    it 'sets entry_station to nil' do
      subject.top_up min_fare
      subject.touch_in entry_station
      subject.touch_out
      expect(subject.entry_station).to be_nil
    end
  end

  describe "#top_up" do
    it 'tops up balance' do
      expect{subject.top_up(10)}.to change {subject.balance}.by 10
    end

    it 'raises error when exceeding top_up limit' do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect{subject.top_up(1)}.to raise_error("limit #{limit} reached")
    end
  end

=begin
 This is now a private method. No unit tests for private methods.

  describe "#deduct" do
    it 'deducts the fare amount from balance' do
      subject.top_up(100)
      expect{subject.deduct(50)}.to change {subject.balance}.by -50
    end
  end
=end

end
