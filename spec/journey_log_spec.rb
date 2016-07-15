require 'journey_log'

describe JourneyLog do

  let(:entry_station) {double (:station)}
  let(:exit_station) {double (:station)}

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

    it 'adds the exit station to the journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journey.journey[:exit]).to eq exit_station
    end
  end



end
