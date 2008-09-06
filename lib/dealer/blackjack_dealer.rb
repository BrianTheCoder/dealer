class BlackjackDealer < Player
  def initialize
    super
    @purse = 0
  end
  
  def decide
    if total < 17
      :hit
    else
      :stand
    end
  end
  
  def visible_card
    @hand.first
  end
  
  def total
    values = @hand.map{|c| c[:value]}
    ace = values.delete(Ace)
    sum = values.inject(0){|total, val| total += val.to_i; total}
    sum += (sum > 10) ? 1 : 11 unless ace.nil?
    return sum
  end
end