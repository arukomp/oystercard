require 'journey_log'

describe JourneyLog do
  let (:subject) { JourneyLog.new(Journey)}
  let(:entry_station) {double (:station)}
  let(:exit_station) {double (:station)}
  #let(:journey) {double (:journey)}
  let(:journey) { {entry: entry_station, exit: exit_station} }

  it {is_expected.to respond_to(:start)}
  it {is_expected.to respond_to(:finish)}
  it {is_expected.to respond_to(:journeys)}
  it {is_expected.to respond_to(:current_journey)}

  context '#start' do

    it 'adds the entry station to the journey' do
      subject.start(entry_station)
      expect(subject.journey.journey[:entry]).to eq entry_station
    end
  end

  context '#finish' do

    before do
      subject.start(entry_station)
      subject.finish(exit_station)
    end

    it 'adds the exit station to the journey' do
      expect(subject.journey.journey[:exit]).to eq exit_station
    end

    it 'saves the journey when finished' do
      expect(subject.journeys).to include journey
    end

  end

  context 'initialize' do

    it 'saves the journey class paramater' do
      expect(subject.journey_class).to eq Journey
    end
  end

  context 'current_journey' do

    it 'returns the current journey when incomplete' do
      allow(subject.journey).to receive(:journey_complete?).and_return false
      expect(subject.current_journey).to_not be_journey_complete
    end

    it 'returns a new journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.current_journey).to_not be_journey_complete
    end
  end

  context 'the clone' do

    it 'stuff' do
      subject.start(entry_station)
      subject.finish(exit_station)
      clone = subject.journeys
      clone << entry_station
      expect(subject.journeys).to_not eq clone

    end
  end

end
