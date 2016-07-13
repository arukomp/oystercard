require 'journey'

describe Journey do
  let(:station) { double(:station) }

  it "remembers the touch in station" do
    subject.start_journey(station)
    expect(subject.current_journey[:entry]).to eq station
  end

  it "remembers the touch out station" do
    subject.end_journey(station)
    expect(subject.current_journey[:exit]).to eq station
  end



end
