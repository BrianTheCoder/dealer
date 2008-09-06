require 'logger'
class Game
  attr_accessor :num_of_decks, :boot, :table_size, :logger, :players, :min_bet, :max_bet, :hand_size, :pot, :house
  
  def initialize
    @logger = Logger.new("#{self.class.to_s}-#{Time.now.to_i}.log")
    @players = []
    @pot = 0
    @house = 0
  end
  
  def deal
    @logger.info("New #{self.class.to_s} game was dealt at #{Time.now}")
    @players.each do |player|
      if player.purse < min_bet
        @players.delete(player)
        @logger.info("#{player.name} is broke and was removed from the game")
      else
        player.hand = []
      end
    end
  end
end