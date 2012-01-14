class AuthController < ApplicationController
  def client
    OAuth2::Client.new('api_key', 'api_secret', :site => 'https://graph.facebook.com')
  end
  
end