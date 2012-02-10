class VoteController < ApplicationController
  # GET /show?male=true
  def index 
    if (session[:current_id])
      @male = params[:male]
      @current_user = User.find session[:current_id]
      @user1, @user2 = @current_user.friends.find_all_by_male(params[:male] == "true").sample(2)
    else
      redirect_to root_url
    end
    
  end
  
  # GET /voting/choose?winner_id=234234&loser_id=567567&male=true
  def choose
    @male = params[:male]
    @winner = User.find(params[:winner_id])
    @loser  = User.find(params[:loser_id])

    User.compute_win(@winner, @loser)

    redirect_to vote_url(male: @male)
  end
end
