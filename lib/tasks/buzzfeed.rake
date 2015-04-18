require 'rest-client'
require 'json'
# require 'alchemy-api-rb'

days_ago = '1429288230'
today = '1429322430'
buzzes_url = 'http://www.buzzfeed.com/buzzfeed/api/buzzes?since=' + days_ago + '&until=' + today + '&session_key=0cbc75f25b34eaef2a8bc1b3e29af94d730cfaafa1ee01152aa6f54eb5f3042chackathon5'


# resource = RestClient.get(buzzes_url)


namespace :buzzfeed do
  desc "Retrieve Sentiment Analysis for BuzzFeed Buzzes"
  task retrieve_sentiment: :environment do
    # puts buzzes_url
    # buzzes.to_json

    buzzes = JSON.parse(RestClient.get(buzzes_url))['buzzes']
  
    buzzes[0..200].each do |buzz|
      buzz_desc = buzz['title'] + ' ' + buzz['description']

      buzz_title = buzz['title']
      #puts buzz_title
      #puts buzz_desc 
      
      sentiment_score = JSON.parse(RestClient.get 'http://access.alchemyapi.com/calls/text/TextGetTextSentiment', {:params => {:apikey =>'632df305942c37cac9034c08e06b3570b66bbc3d', :text => buzz_desc, :outputMode => :json}})
     #uts sentiment_score 
      
      buzz1 = Buzz.find_or_create_by(buzz_id: buzz['id'])
      buzz1.username = buzz['username']
      buzz1.uri = buzz['uri']
      buzz1.image_url = buzz['image'].gsub('.jpg', '_dblbig.jpg')
      buzz1.sentiment_score = sentiment_score['docSentiment']['score']
      buzz1.title = buzz["title"]
      buzz1.save!
      puts Buzz
      puts sentiment_score
      sleep(2.0)

    end
  
  end

end
