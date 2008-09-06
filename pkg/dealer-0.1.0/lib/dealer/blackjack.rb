class Blackjack < Game
  has 1, :dealer, :class_name => "BlackjackDealer"
  attr_accessor :cut_index
  
  PLAYER_CLASSES = [BlackjackPlayer]
  
  def initialize
    super
    @num_of_decks = 6
    @boot = Boot.new(num_of_decks).shuffle!
    @cut_index = rand(@boot.size / 2)
    @hand_size = 2
    @table_size = (6..8).pick
    p table_size
    @min_bet = 5
    @max_bet = 500
    self.dealer = BlackjackDealer.new
    table_size.times do
      players << PLAYER_CLASSES.pick.new
    end
  end
  
  def deal
    super
    dealer.hands << Hand.new
    place_bets
    @hand_size.times do
      (players + [dealer]).each{|person| person.hands.last << @boot.deal}
    end
  end
  
  def payout
    dealer_score = dealer.total
    players.each do |player|
      if dealer_score == 21 and dealer.hands.last.size == 2
        p "dealer blackjack"
        player.purse -= player.bet
      elsif player.total == 21 and player.hands.last.size == 2
        p "player blackjack"
        player.purse += (1.5 * player.bet)
      elsif player.total > dealer_score && player.total <= 21
        p "player beat dealer"
        player.purse += player.bet
      elsif dealer_score > 21 && player.total <= 21
        p "dealer bust"
        player.purse += player.bet
      elsif player.total > 21
        p "player bust"
        player.purse -= player.bet
      elsif dealer_score > player.total && dealer_score <= 21
        p "dealer wins"
        player.purse -= player.bet
      end
      player.save
    end
    check_cut_index
  end
  
  def check_decisions
    (players + [dealer]).each do |person|
      ask_decision(person)
    end
  end
  
  def ask_decision(person)
    loop do
      case person.decide(dealer)
      when :hit then
        person.hands.last << @boot.deal
      when :stand then
        break
      when :doubledown
        person.bet *= 2
        person.hands.last << @boot.deal
        break
      when :split
      end
    end
  end
  
  def check_cut_index
    if (@boot.size - (@table_size + 2) * @hand_size) < @cut_index
      @boot = Boot.new(@number_of_decks).shuffle!
    end
  end
  
  def place_bets
    players.each do |player|
      player.bet = @min_bet
    end
  end
  
  def run
    deal
    check_decisions
    payout
    save
  end
end

class King
  def self.to_i; 10 end
end

class Queen
  def self.to_i; 10 end
end

class Jack
  def self.to_i; 10 end
end