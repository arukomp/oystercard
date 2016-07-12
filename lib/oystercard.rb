
class Oystercard
  MAX_LIMIT = 90

  attr_accessor :balance, :in_use

  def initialize
     @balance = 0
     @in_use = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_LIMIT} reached" if amount + balance > MAX_LIMIT
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

  def in_journey?
    in_use
  end

  def touch_in
    self.in_use = true
  end

  def touch_out
    self.in_use = false
  end

end
