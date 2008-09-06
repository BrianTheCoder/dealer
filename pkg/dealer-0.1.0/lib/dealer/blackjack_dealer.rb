class BlackjackDealer < Player
  def initialize
    super
    @purse = 0
  end
  
  def decide(dealer)
    if hands.last.total < 17
      :hit
    else
      :stand
    end
  end
  
  def visible_card
    hands.first.cards.first
  end
  
end