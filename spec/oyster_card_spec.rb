require 'oyster_card'

describe OysterCard do

  context "Balance" do
    it 'should be shown' do
      expect(subject.balance).to be_a(Fixnum)
    end
  end
  context "Top up" do
    it 'should top up card by 5' do
      expect{subject.top_up(5)}.to change{ subject.balance }.by 5
    end
    it 'should not allow to top up above limit' do
      expect{subject.top_up(95)}.to raise_error "You are exceeding the limit of £#{OysterCard::LIMIT}"
    end
  end
end
