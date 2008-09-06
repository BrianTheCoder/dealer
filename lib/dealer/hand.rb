class Hand
  include DataMapper::Resource

  property :id,                 Serial
  property :card_string,        String
  property :player_id,          Integer
  property :created_at,         DateTime
  
  attr_accessor :cards
  
  def initialize
    @cards = []
  end
  
  def values
    @values = @cards.map{|c| c[:value]}
  end
  
  def <<(card)
    @cards << (card)
  end

  def size
    @cards.size
  end
  
  def total
    @vals = values
    ace = @vals.delete(Ace)
    sum = @vals.inject(0){|total, val| total += val.to_i; total}
    sum += (sum > 10) ? 1 : 11 unless ace.nil?
    return sum
  end
  
  before :save do
    attribute_set(:card_string, @cards.map{|c| "#{c[:value]}:#{c[:suit]}"}) 
  end
  
end