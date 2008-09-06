require 'logger'
class Game
  include DataMapper::Resource

  property :id,                 Serial
  property :type,               Discriminator
  property :table_size,         Integer
  property :num_of_decks,       Integer
  property :min_bet,            Integer
  property :max_bet,            Integer
  property :hand_size,          Integer
  property :created_at,         DateTime
  
  has n, :players
  attr_accessor :boot, :logger, :pot, :house
  
  def initialize
    @players = []
    @pot = 0
    @house = 0
  end
  
  def deal
    players.each do |player|
      if player.purse < min_bet
        players.delete(player)
      else
        player.hands << Hand.new
      end
    end
  end
end