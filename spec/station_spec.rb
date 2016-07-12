require 'station'

describe Station do

  describe 'initialize with correct values' do
    it 'expects station_name and zone to be passed' do
      expect(subject).to respond_to(:new).with(2).arguments
    end

    it { is_expected.to respond_to(:new).with(2).arguments}
  end

end
