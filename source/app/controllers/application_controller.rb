require 'pp'
class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    puts '### authenticating (ApplicationController).###'
    ENV['access_token'] = dbdc_client.oauth_token
    ENV['instance_url'] = dbdc_client.instance_url
    ENV['api_version'] = dbdc_client.version

    puts '### client is ' + dbdc_client.to_s
    pp '### access_token is ' + ENV['access_token']
  end

  protected
  def basic_auth
    request_http_basic_authentication do |username, password|
      if
        username == 'ray' && password == 'gao'
        return true
      else
        return false
      end
    end
    #authenticate_or_request_with_http_basic do |username, password|
    #  username == 'ray' && password = 'gao'
    #end
  end
end
