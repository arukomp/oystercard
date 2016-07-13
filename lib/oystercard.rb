class Oystercard

  attr_reader :balance, :min_fare, :entry_station, :history

  LIMIT = 150
  MINFARE = 1

  def initialize
    @balance = 0
    @min_fare = MINFARE
    @history = []
  end

  def top_up amount
    fail "limit #{LIMIT} reached" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    true if !entry_station.nil?
  end

  def touch_in entry_station
    fail "balance too low" if @balance < @min_fare
    @entry_station = entry_station
  end

  def touch_out
    deduct(min_fare)
    @history << @entry_station
    @entry_station = nil
  end

  private

  def deduct amount
    @balance -= amount
  end

end
