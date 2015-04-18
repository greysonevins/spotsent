class UsersController < ApplicationController
require 'musix_match'
require 'json'
MusixMatch::API::Base.api_key = '125703e9fa9d28c1c7f4dc964b16a572'
AlchemyAPI.key = "7b529a2774d291975d6c1bcf3ac8914f652657f4"
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
    puts RestClient.get 'http://access.alchemyapi.com/calls/text/TextGetTextSentiment', {:params => {:apikey =>'7b529a2774d291975d6c1bcf3ac8914f652657f4', :text => lyrics}}

    AlchemyAPI.configure do |config|
    config.apikey = "7b529a2774d291975d6c1bcf3ac8914f652657f4"
    config.output_mode = :xml # not yet supported
    results = AlchemyAPI.search(:keyword_extraction, text: lyrics)
    puts results
    end
    end

    def show 
    end
end