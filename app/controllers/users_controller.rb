class UsersController < ApplicationController
require 'musix_match'
require 'json'
MusixMatch::API::Base.api_key = '125703e9fa9d28c1c7f4dc964b16a572'
require 'rest-client'

  def spotify

    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    spotify_user.saved_tracks
    # hash = spotify_user.to_hash
    # spotify_user = RSpotify::User.new(hash)
    #puts spotify_user.inspect
    #puts spotify_user.country
    #puts spotify_user.email
    #hash = spotify_user.to_hash
    t = spotify_user.saved_tracks[0].to_json
    obj = JSON.parse(t)
    title = obj["name"]
    artist = obj["artists"][0]["name"]
    puts artist
    track_id = "0"
    lyrics = "x"
    # playlist = spotify_user.create_playlist!('my-awesome-playlist')
    redirect_to  home_show_path
 
    response = MusixMatch.search_track(:q_track => title, :q_artist => artist)
    
        if response.status_code == 200
         response.each do |track|
           
            v = track.to_json
            x = JSON.parse(v)
            track_id = x["track_id"]
            puts track_id
         end
     end

     response = MusixMatch.get_lyrics(track_id)
     if response.status_code == 200 && lyrics = response.lyrics
        lyrics = lyrics.lyrics_body
         puts lyrics
         end


     x_obj = RestClient.get 'http://access.alchemyapi.com/calls/text/TextGetTextSentiment', {:params => {:apikey =>'ee6310439b04d809d4521ae5a416b4bace63d448', :text => lyrics, :outputMode => :json}}
     sent_obj = JSON.parse(x_obj)
     docsent = sent_obj["docSentiment"]["score"]

     puts docsent
  



    end

    def show 
    end
end