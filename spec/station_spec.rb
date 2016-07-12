require 'station'

describe Station do

  describe 'initialize with correct values' do
    subject{ described_class.new("Kings Cross", 2) }
    it { expect(subject.station_name).to eq "Kings Cross" }
    it { expect(subject.zone).to eq 2 }
  end


end
