class Oystercard

  attr_reader :balance, :min_fare, :history, :journey

  LIMIT = 150
  MINFARE = 1

  def initialize
    @balance = 0
    @min_fare = MINFARE
    @history = []
    @journey = {}
  end

  def top_up amount
    fail "limit #{LIMIT} reached" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    !@journey[:enter].nil?
  end

  def touch_in entry_station
    fail "balance too low" if @balance < @min_fare
    @journey[:enter] = entry_station
  end

  def touch_out exit_station
    deduct(min_fare)
    @journey[:exit] = exit_station
    @history << @journey.clone
    @journey[:enter] = nil
  end

  private

  def deduct amount
    @balance -= amount
  end

end
