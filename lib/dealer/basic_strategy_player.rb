#implementing the basic strategy black jack player
class BasicStrategyPlayer < Player
  
  def initialize
    super
    @purse = 500
  end
  
  #       2 3 4 5 6 7 8 9 10 A
  #   5   H H H H H H H H H H
  #   6   H H H H H H H H H H
  #   7   H H H H H H H H H H
  #   8   H H H H H H H H H H
  #   9   H D D D D H H H H H
  #  10   D D D D D D D D H H
  #  11   D D D D D D D D D H
  #  12   H H S S S H H H H H
  #  13   S S S S S H H H H H
  #  14   S S S S S H H H H H
  #  15   S S S S S H H H H H
  #  16   S S S S S H H H H H
  #  17   S S S S S S S S S S
  # A,2   H H H D D H H H H H
  # A,3   H H H D D H H H H H
  # A,4   H H D D D H H H H H
  # A,5   H H D D D H H H H H
  # A,6   H D D D D H H H H H
  # A,7   S D D D D S S H H H
  # A,8   S S S S S S S S S S
  # A,9   S S S S S S S S S S
  # 2,2   P P P P P P H H H H
  # 3,3   P P P P P P H H H H
  # 4,4   H H H P P H H H H H
  # 5,5   D D D D D D D D H H
  # 6,6   P P P P P H H H H H
  # 7,7   P P P P P P H H H H
  # 8,8   P P P P P P P P P P
  # 9,9   P P P P P S P P S S
  # T,T   S S S S S S S S S S
  # A,A   P P P P P P P P P P
  
  def decide(dealer)
    @dealer_card = dealer.visible_card[:value]
    @card_total = hands.last.total
    if values.include?(Ace)
      if (values.include?(2) || values.include?(3)) && [5,6].include?(@dealer_card)
        :doubledown #hit
      elsif values.include?(2) || values.include?(3)
        :hit
      elsif (values.include?(4) || values.include?(5)) && [4,5,6].include?(@dealer_card)
        :doubledown #hit
      elsif values.include?(4) || values.include?(5)
        :hit
      elsif values.include?(6) && [3,4,5,6].include?(@dealer_card)
        :doubledown #hit
      elsif values.include?(6)
        :hit
      elsif values.include?(7) && [2,7,8].include?(@dealer_card)
      elsif values.include?(7) && [3,4,5,6].include?(@dealer_card)
        :doubledown #stand
      elsif values.include?(7)
        :hit
      elsif values.include?(8) || values.include?(9)
        :stand
      elsif values.first == values.last
        :split
      end
    elsif values.first == values.last
      if [2,3,7].include?(values.first) && @dealer_card <= 7
        :split
      elsif [2,3,7].include?(values.first)
        :hit
      elsif values.first == 4 && [5,6].include?(@dealer_card)
        :split
      elsif values.first == 4
        :hit
      elsif values.first == 5 && #dealer_card <= 9
        :doubledown #hit
      elsif values.first == 5 
        :hit
      elsif values.first == 6 && @dealer_card <= 6
        :split
      elsif values.first == 6
        :hit
      elsif values.first == 8
        :split
      elsif values.first == 9 && [2,3,4,5,6,8,9].include?(@dealer_card)
        :split
      elsif values.first == 9
        :stand
      elsif values.first.to_i == 10
        :split
      end
    else
      if (5...8).include?(@card_total)
        :hit
      elsif @card_total == 9 && (3...6).include?(@dealer_card)
        :doubledown #hit
      elsif @card_total == 9
        :hit
      elsif @card_total == 10 && (2...9).include?(@dealer_card)
        :doubledown #hit
      elsif @card_total == 10
        :hit
      elsif @card_total == 11 && ((2...10)+[Jack, Queen, King]).include?(@dealer_card)
        :doubledown #hit
      elsif @card_total == 11
        :hit
      elsif @card_total == 12 && [4,5,6].include?(@dealer_card)
        :stand
      elsif @card_total == 12
        :hit
      elsif (13...16).include?(@card_total) && @dealear_card <= 6
        :stand
      elsif (13...16).include?(@card_total) && (@dealer_card >= 7 || @dealer_card.is_a?(Ace))
        :hit
      elsif @card_total == 17
        :stand
      end
    end
  end

end