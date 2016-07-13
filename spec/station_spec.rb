require 'station'

describe Station do
  let(:subject) { described_class.new("London", 2) }

  it 'allows to see the station name' do
    expect(subject.name).to eq "London"
  end

  it 'allows to see the station zone' do
    expect(subject.zone).to eq 2
  end

end
