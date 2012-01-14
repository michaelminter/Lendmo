class SessionsController < ApplicationController
  def create
    user = User.build(auth_hash)
    # sign_in user
    redirect_to user
  end
  
  def destroy
    # sign_out
    redirect_to root_path
  end
  
  protected
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
