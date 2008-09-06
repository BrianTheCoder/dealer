class Player
  attr_accessor :hand, :name, :purse, :bet
  
  def initialize
    @name = "#{/\w+/.gen}-#{self.class.to_s}"
  end
  
  def decide; end
  
  def identifier
    "#{@name}"
  end
end