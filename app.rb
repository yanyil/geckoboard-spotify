require 'dotenv'
require 'rufus-scheduler'
require_relative 'lib/geckoboard_request'
require_relative 'lib/spotify'

API_KEY = Dotenv.load['GECKOBOARD_API_KEY']
ARTIST_ID = "43ZHCT0cAZBISjO8DG9PnE"
INTERVAL = '2s'

gecko = GeckoboardRequest.new(API_KEY)
spotify = Spotify.new(ARTIST_ID)
scheduler = Rufus::Scheduler.new

artist_fields = [
  Geckoboard::NumberField.new(:followers, name: 'Followers'),
  Geckoboard::NumberField.new(:popularity, name: 'Popularity'),
]
artist_data = [
  {
    followers: spotify.get_followers,
    popularity: spotify.get_popularity
  },
]

top_tracks_fields = [
  Geckoboard::StringField.new(:track, name: 'Track'),
  Geckoboard::NumberField.new(:popularity, name: 'Popularity'),
]
top_tracks_data = spotify.get_top_tracks("GB")

scheduler.every INTERVAL do
  gecko.update("artist", artist_fields, artist_data)
  gecko.update("top_tracks", top_tracks_fields, top_tracks_data)
  puts "Data added"
end

scheduler.join