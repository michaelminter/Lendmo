class PagesController < ApplicationController
  def home
    @title = "Lendmo Home"
    if signed_in?
      redirect_to '/feed'
      # redirect_to current_user
    end
  end
  
  def feed
    @title = "Lendmo Activity Feed"
    @events = current_user.feed_events(session[:token])
    if !signed_in?
      redirect_to root_path, :notice => "Must be signed in!"
    end
  end
end