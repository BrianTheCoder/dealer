$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'randexp'

%w(game player blackjack blackjack_player boot blackjack_dealer deck version).each do |file|
  require File.join(File.dirname(__FILE__), 'dealer', file)
end