require 'oystercard'

describe Oystercard do
min_fare = Oystercard::MINFARE
let(:entry_station) {double('entry_station')}
let(:exit_station) {double('exit_station')}
let(:journey) {{:enter => entry_station, :exit => exit_station}}

  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end

  it 'in_journey returns false initially' do
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    before do
      subject.top_up(min_fare)
      subject.touch_in entry_station
    end
    it 'can touch_in' do
      expect(subject).to be_in_journey
    end
    it 'stores entry station' do
      expect(subject.journey[:enter]).to eq entry_station
    end
  end

  context 'balance below minimum fare' do
    it 'raises error if balance is less than minimum fare' do
      expect{subject.touch_in entry_station}.to raise_error "balance too low"
    end
  end

  describe '#touch_out' do

    before do
      subject.top_up(min_fare)
      subject.touch_in entry_station
    end
    it 'deducts the fare when we touch out' do
      expect{subject.touch_out exit_station}.to change {subject.balance}.by -min_fare
    end
    it 'can touch out' do
      subject.touch_out exit_station
      expect(subject).not_to be_in_journey
    end
    it 'sets entry station to nil' do
      subject.touch_out exit_station
      expect(subject.journey[:enter]).to be_nil
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

  describe "#history" do
    it 'returns journey history' do
      expect(subject.history).to be_empty
    end
    it 'saves journey inside history' do
      subject.top_up min_fare
      subject.touch_in entry_station
      subject.touch_out exit_station
      expect(subject.history).to include journey
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
