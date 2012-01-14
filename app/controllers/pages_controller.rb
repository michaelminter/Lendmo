class PagesController < ApplicationController
  def home
    @title = "Lendmo Home"
    if signed_in?
      redirect_to current_user
    end
  end
  
end