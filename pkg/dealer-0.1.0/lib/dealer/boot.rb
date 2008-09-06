class Boot < Array
  
  def initialize(size = 1)
    size.times do 
      self << Deck.new.flatten
    end
    self.flatten!
  end
  
  def add_deck(n = 1)
    n.times do 
      self << Deck.new.flatten
    end
    self.flatten!
  end
  
  def shuffle!
    sort{ rand(size) - 1 }
  end
  
  def deal
    self.pop
  end
end