class SessionsController < ApplicationController
  def create
    @user = User.create(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end
  
  def destroy
    @user = nil
    self.current_user = nil
    redirect_to '/'
  end
  
  protected
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
