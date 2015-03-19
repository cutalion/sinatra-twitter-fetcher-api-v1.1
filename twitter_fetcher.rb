require 'sinatra'
require 'sinatra/cross_origin'
require 'json'
require 'rubygems'
require 'twitter'

class TwitterFetcher < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
  end

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
    pass if params[:screen_name].to_s.strip.empty?

    @@twitter_client.user(params[:screen_name]).attrs.to_json
  end
end
