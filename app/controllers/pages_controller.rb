class PagesController < ApplicationController
  def home
    @title = "Lendmo Home"
    @token = params[:token]
    @user = params[:fb_user]
  end
  
end