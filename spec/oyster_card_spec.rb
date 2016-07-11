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
      subject.top_up(OysterCard::LIMIT)
      message = "You are exceeding the limit of £#{OysterCard::LIMIT}"
      expect{subject.top_up(1)}.to raise_error message
    end
  end

  context "Deduct" do
    it 'should deduct the correct fare from the balance' do
      subject.top_up(1)
      expect{ subject.deduct(1) }.to change{ subject.balance }.by -1
    end
  end

  context "in journey?" do
    it 'should check if card is in journey' do
      expect(subject).to_not be_in_journey
    end
  end

  context "touch in" do
    it 'initialize journey when touching in' do
      subject.touch_in!
      expect(subject).to be_in_journey
    end
  end

  context "touch out" do
    it 'ends journey when touching out' do
      subject.touch_out!
      expect(subject).to_not be_in_journey
    end
  end
end
