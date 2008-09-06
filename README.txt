Dealer is a way to simulate card games.

You have your base game class, subclass it in order to create a new card game. I've already written blackjack. Then you write a bot to play the game. The existing black jack bots just follow the basic dealer strategy, basic strategy and card counting will come soon.

To use it you just do

require 'dealer'
bj = Blackjack.new
bj.run

Then take a look at the log. I'll make the log path configurable later for now it just logs to your current directory.