require 'rest-client'
require 'json'
# require 'alchemy-api-rb'

days_ago = '1429265820'
today = '1429338017'
buzzes_url = 'http://www.buzzfeed.com/buzzfeed/api/buzzes?since=' + days_ago + '&until=' + today + '&session_key=0cbc75f25b34eaef2a8bc1b3e29af94d730cfaafa1ee01152aa6f54eb5f3042chackathon5'


# resource = RestClient.get(buzzes_url)


namespace :buzzfeed do
  desc "Retrieve Sentiment Analysis for BuzzFeed Buzzes"
  task retrieve_sentiment: :environment do
    # puts buzzes_url
    # buzzes.to_json

    buzzes = JSON.parse(RestClient.get(buzzes_url))['buzzes']
  
    buzzes.each do |buzz|
      buzz_desc = buzz['title'] + ' ' + buzz['description']
      puts buzz_desc 
      
      sentiment_score = JSON.parse(RestClient.get 'http://access.alchemyapi.com/calls/text/TextGetTextSentiment', {:params => {:apiKey => 'ca9a90e1b69c582d2856b6baa8f27b217e3fa58d', :text => buzz_desc, :outputMode => :json}})
     puts sentiment_score 
      Buzz.create!(buzz_id: buzz['id'], sentiment_score: sentiment_score['docSentiment']['score'])

    end
  
  end

end
