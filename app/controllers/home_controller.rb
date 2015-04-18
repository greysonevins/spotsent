class HomeController < ApplicationController
	require 'musix_match'
	require 'json'
	MusixMatch::API::Base.api_key = '125703e9fa9d28c1c7f4dc964b16a572'
	require 'rest-client'
 	@sent_analy = "097"
  def index
  end
 

  def show
    
  	 # response = MusixMatch.search_track(:q_track => title, :q_artist => artist)
    
    #     if response.status_code == 200
    #      response.each do |track|
           
    #         v = track.to_json
    #         x = JSON.parse(v)
    #         track_id = x["track_id"]
    # #         puts track_id
    #      end
     end

     response = MusixMatch.get_lyrics(track_id)
     if response.status_code == 200 && lyrics = response.lyrics
        lyrics = lyrics.lyrics_body
         puts lyrics
         end


     x_obj = RestClient.get 'http://access.alchemyapi.com/calls/text/TextGetTextSentiment', {:params => {:apikey =>'f1be26276fc7908c337081b3dd9c54b3b0059765', :text => lyrics, :outputMode => :json}}
     sent_obj = JSON.parse(x_obj)
     docsent = sent_obj["docSentiment"]["score"]

     @sent_analy = docsent
  end
	
end
