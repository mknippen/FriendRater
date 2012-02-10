class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  
  def self.compute_win(winner_id, loser_id)
      # do the math here
      winner = User.find(winner_id)
      loser = User.find(loser_id)
  
      winner.increment(:wins)
      loser.increment(:losses)

      # etc. etc.
      # updating of attributes, etc. etc.
      elo_winner = Elo::Player.new(rating: winner.rating, games_played: winner.total)
      elo_loser = Elo::Player.new(rating: loser.rating, games_played: loser.total)
      
      elo_winner.wins_from(elo_loser)
      
      winner.rating = elo_winner.rating
      loser.rating = elo_loser.rating
      
      winner.save
      loser.save
  end
  
  def total
    wins+losses
  end  
  
end
