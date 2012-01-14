class AuthController < ApplicationController
    
  def start
    redirect_to client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => 'email,offline_access')
  end
  
  def callback
    access_token = client.auth_code.get_token('authorization_code_value', :redirect_uri => redirect_uri)
    session[:fb_user] = JSON.parse(access_token.get('/me'))
    
    redirect_to :controller => :pages,
                :action => :home,
                :token => access_token.token
  end
  
  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/login/callback'
    uri.query = nil
    uri.to_s
  end
  
  # Log out of Lendmo
  def destroy
    session[:fb_user] = nil
    redirect_to root_path
  end
  
  
  protected
  
  def client
    facebook_settings = YAML::load(File.open("#{Rails.root}/config/facebook.yml"))
    app_id = facebook_settings['application_id']
    secret_key = facebook_settings['secret_key']
    OAuth2::Client.new("#{app_id}", "#{secret_key}", :site => 'https://graph.facebook.com')
  end
  
end
