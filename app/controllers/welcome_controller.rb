class WelcomeController < ApplicationController
  def index
    if session[:current_id]
      redirect_to vote_url
    end
  end
  
  def authenticate
    session[:access_token] = Koala::Facebook::OAuth.new('345893595441870', 'f6c647d7783ebcd16d516ad85be96c8b', authenticate_url).get_access_token(params[:code]) if params[:code]

    @graph = Koala::Facebook::GraphAPI.new(session[:access_token])
    current_id, current_name, current_gender = @graph.get_object("me?fields=id,name,gender").values
    @current_user = User.find_or_initialize_by_fb_id(current_id)
    @current_user.name = current_name
    @current_user.male = (current_gender == 'male')
    @current_user.save
    session[:current_id] = @current_user.id
    
    #logger.debug @graph.get_object("me?fields=id")
    @friends = @graph.get_connections("me", "friends?fields=id,name,gender")
    @friends.each do |friend|
      fb_id, name, gender = friend.values
      @user = User.find_or_initialize_by_fb_id(fb_id)
      @user.name = name
      @user.male = (gender == 'male')
      @user.save
      @current_user.friends << @user
    end
    redirect_to vote_url(male: !@current_user.male)
  end
  
  def logout
    session[:current_id] = nil
    session[:access_token] = nil
    redirect_to login_url
  end
  
end
