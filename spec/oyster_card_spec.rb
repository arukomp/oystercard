require 'oyster_card'

describe OysterCard do

  context "Balance" do
    it 'should be shown' do
      expect(subject.balance).to be_a(Fixnum)
    end
  end

end
