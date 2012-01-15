class PagesController < ApplicationController
  def home
    @title = "Lendmo Home"
    if signed_in?
      # redirect_to '/feed'
      # redirect_to current_user
    end
  end
  
  def feed
    @title = "Lendmo Activity Feed"
    @user = User.find(current_user)
    # @events = @user.feed_events(session[:token])
    @events = @user.feed_events(session[:token])
    @friends = @user.friends(session[:token])
    @item = Item.new
    @event = Event.new
    if !signed_in?
      redirect_to root_path, :notice => "Must be signed in!"
    end
  end
  
end