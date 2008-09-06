$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'randexp'
require 'dm-core'
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3:card_data.rb")

%w(game player blackjack_player boot blackjack_dealer basic_strategy_player deck blackjack version hand).each do |file|
  require File.join(File.dirname(__FILE__), 'dealer', file)
end