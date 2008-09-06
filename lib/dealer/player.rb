class Player
  include DataMapper::Resource

  property :id,                 Serial
  property :type,               Discriminator
  property :created_at,         DateTime
  property :game_id,            Integer
  
  has n, :hands, :order => [:created_at.desc]
  belongs_to :game
  
  attr_accessor :purse, :bet
  
  def initialize
    @name = "#{/\w+/.gen}-#{self.class.to_s}"
  end
  
  def decide; end
  
  def identifier
    "#{@name}"
  end
  
  def values
    @values = hands.last.cards.map{|c| c[:value]}
  end
  
  def total
    @total = hands.last.total
  end
  
  after :save do
    hands.each{|h| h.save}
  end
end