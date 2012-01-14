class SessionsController < ApplicationController
  def create
    user = User.find_or_create(auth_hash)
    # sign_in user
    session[:token] = auth_hash[:credentials][:token]
    self.current_user = user
    redirect_to user
  end
  
  def destroy
    # sign_out
    session[:token] = nil
    self.current_user = nil
    redirect_to root_path
  end
  
  protected
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
