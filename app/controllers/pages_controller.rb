class PagesController < ApplicationController
  def home
    @title = "Lendmo Home"
    if signed_in?
      redirect_to '/feed'
    end
  end
  
  def feed
    @title = "Lendmo Activity Feed"
    @user = User.find(current_user)
    @events = @user.feed_events(session[:token]).paginate(:page => params[:page], :per_page => 10)
    @friends = @user.friends(session[:token])
    @item = Item.new
    @event = Event.new
    if !signed_in?
      redirect_to root_path, :notice => "Must be signed in!"
    end
  end
  
end