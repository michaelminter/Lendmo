module SessionsHelper
  def sign_in(user)
    cookies.signed[:remember_token] = [user.id, user.email]
    session[:current_user] = user.id
  end

  def current_user=(user)
    session[:current_user] = user.id
  end

  def current_user
    if session[:current_user]
      user_from_remember_token
    else
      User.find(session[:current_user])
    end
end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !session[:current_user].nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    session[:current_user] = nil
    session[:token] = nil
    current_user = nil
  end

  def deny_access
    redirect_to root_path, :notice => "Please log in."
  end

  private

  def user_from_remember_token
    User.find(*remember_token.first)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
