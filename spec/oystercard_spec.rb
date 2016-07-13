require 'oystercard'

describe Oystercard do
  it 'new oystercard has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it "should increase the balance by top up amount" do
    expect{subject.top_up(10)}.to change{subject.balance}.by(+10)
  end

  it "should deduct the balance by deduction amount" do
    expect{subject.deduct(10)}.to change{subject.balance}.by(-10)
  end

  it 'should throw an excption if balance exceeds 90' do
    maximum = Oystercard::MAX_BALANCE
    expect{ subject.top_up(maximum+1) }.to raise_error 'Maximum amount exceeded'
  end

  it 'is not in a journey to start with' do
    expect(subject).not_to be_in_journey
  end

  it 'touch in changes the state of the journey' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'touch out returns the in journey as false' do
    subject.touch_in
    subject.touch_out
    expect(subject).to_not be_in_journey
  end

end
