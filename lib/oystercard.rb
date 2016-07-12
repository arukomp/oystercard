
class Oystercard
  MAX_LIMIT = 90

  attr_accessor :balance

  def initialize
     @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_LIMIT} reached" if amount + balance > MAX_LIMIT
    self.balance += amount
  end

end
