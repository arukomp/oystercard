require 'journey'

describe Journey do

  let(:station) { double(:station) }
  let(:exit_station) { double(:exit_station) }

  it 'should expect the journey to be empty' do
    expect(subject.journey).to be_empty
  end

  it 'is able to start a journey' do
    subject.start(station)
    expect(subject.journey[:entry]).to eq station
  end

  it 'is able to end a journey' do
    subject.start(station)
    subject.end(exit_station)
    expect(subject.journey[:exit]).to eq exit_station
  end

  it 'calculates the fare of the journey' do
    subject.start(station)
    subject.end(exit_station)
    expect(subject.fare).to eq described_class::MINIMUM_FARE
  end

  describe 'prevents cheating' do

    it 'charges £6 penalty for starting the journey twice' do
      subject.start(station)
      expect{ subject.start(station) }.to change{ subject.fare }.to 6
    end

    it 'charges £6 penalty for ending the journey without starting it' do
      expect{ subject.end(station) }.to change{ subject.fare }.to 6
    end

  end

  describe 'allows to check whether the journey is complete' do

    it 'is not complete if not started first' do
      subject.end(exit_station)
      expect(subject).to_not be_complete
    end

    it 'is not complete if not ended' do
      subject.start(station)
      expect(subject).to_not be_complete
    end

    it 'is complete when both started and ended' do
      subject.start(station)
      subject.end(exit_station)
      expect(subject).to be_complete
    end

  end

end
