class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station


  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station 
  end

  def touch_in(station)
    fail "Sorry, insufficient funds" if @balance < MIN_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MIN_BALANCE)
    @in_journey = false
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
