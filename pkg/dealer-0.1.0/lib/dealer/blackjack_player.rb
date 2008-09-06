class BlackjackPlayer < Player
  def initialize
    super
    @purse = 500
  end
  
  def decide(dealer)
    if hands.last.total < 17
      :hit
    else
      :stand
    end
  end
end