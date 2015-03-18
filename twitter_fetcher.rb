require 'sinatra'
require 'json'
require 'rubygems'
require 'twitter'

class TwitterFetcher < Sinatra::Base
  @@twitter_client = Twitter::Client.new(
    :consumer_key       => ENV['TWITTER_CONSUMER_KEY'],
    :consumer_secret    => ENV['TWITTER_CONSUMER_SECRET'],
    :oauth_token        => ENV['TWITTER_OAUTH_TOKEN'],
    :oauth_token_secret => ENV['TWITTER_OAUTH_TOKEN_SECRET'],
  )

  before do
    content_type 'application/json'
  end

  get '/users/show' do
    @@twitter_client.user(params[:screen_name]).attrs.to_json
  end
end
