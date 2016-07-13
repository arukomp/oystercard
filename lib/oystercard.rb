class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_accessor :balance, :entry_station
  attr_reader :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    self.balance += amount
  end

  def in_journey?
    self.entry_station
  end

  def touch_in(station)
    fail "Sorry, insufficient funds" if balance < MIN_BALANCE
    @in_journey = true
    self.entry_station = station
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @in_journey = false
    @exit_station = station
    @journeys << { "Entry Station:" => @entry_station, "Exit station:" => @exit_station }
  end

  private

  def deduct(amount)
    self.balance -= amount
  end

end
