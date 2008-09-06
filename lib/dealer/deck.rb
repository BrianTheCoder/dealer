class Deck < Array
  
  def initialize
    %w(heart spade club diamond).each do |suit|
      [2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace].each do |val|
        self << {:value => val, :suit => suit}
      end
    end
  end
  
  def deal
    self.pop
  end
  
  def shuffle!
    sort{ rand(size) - 1 }
  end
end

class King; end
class Ace; end
class Queen; end
class Jack; end