class Blackjack < Game
  attr_accessor :dealer, :cut_index
  
  def initialize
    super
    @number_of_decks = 6
    @boot = Boot.new(@number_of_decks).shuffle!
    @cut_index = rand(@boot.size / 2)
    @hand_size = 2
    @table_size = (6..8).pick
    @min_bet = 5
    @max_bet = 500
    @dealer = BlackjackDealer.new
    @table_size.times do
      @players << BlackjackPlayer.new
    end
  end
  
  def deal
    super
    @dealer.hand = []
    place_bets
    @hand_size.times do
      (@players + [@dealer]).each{|person| person.hand << @boot.deal}
    end
    log_deal
  end
  
  def payout
    dealer_score = @dealer.total
    @players.each do |player|
      if dealer_score == 21 and dealer.hand.size == 2
        @logger.info("dealer blackjack")
        player.purse -= player.bet
      elsif player.total == 21 and player.hand.size == 2
        player.purse += (1.5 * player.bet)
        @logger.info("#{player.name} got blackjack")
      elsif player.total > dealer_score && player.total <= 21
        @logger.info("#{player.name}'s #{player.total} beats the dealer's #{dealer_score}")
        player.purse += player.bet
      elsif dealer_score > 21 && player.total <= 21
        @logger.info("dealer busted #{player.name} wins with a #{player.total}")
        player.purse += player.bet
      elsif player.total > 21
        @logger.info("#{player.name} busted with a #{player.total}")
        player.purse -= player.bet
      elsif dealer_score > player.total && dealer_score <= 21
        @logger.info("dealer's #{dealer_score} beats #{player.name}'s #{player.total}")
      end
    end
    check_cut_index
  end
  
  def check_decisions
    (@players + [@dealer]).each do |person|
      ask_decision(person)
    end
  end
  
  def ask_decision(person)
    loop do
      case person.decide
      when :hit then
        @logger.info("#{person.name} hits a #{person.total}")
        person.hand << @boot.deal
        @logger.info("#{person.name} got a #{person.hand.last[:value]} and now has #{person.total}")
      when :stand then
        @logger.info("#{person.name} stands with a #{person.total}")
        break
      when :doubledown
      when :split
      end
    end
  end
  
  def log_deal
    (@players + [@dealer]).each do |player|
      @logger.info("#{player.name} has #{player.hand.map{|c| c[:value]}.join(',')}")
    end
  end
  
  def check_cut_index
    if (@boot.size - (@table_size + 2) * @hand_size) < @cut_index
      @boot = Boot.new(@number_of_decks).shuffle!
    end
  end
  
  def place_bets
    @players.each do |player|
      player.bet = @min_bet
    end
  end
  
  def run
    deal
    check_decisions
    payout
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