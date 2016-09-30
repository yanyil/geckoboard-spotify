require 'geckoboard'
require 'dotenv'
require_relative 'spotify'

API_KEY = Dotenv.load['GECKOBOARD_API_KEY']
client = Geckoboard.client(API_KEY)
client.ping

dataset = client.datasets.find_or_create('artist', fields: [
  Geckoboard::NumberField.new(:followers, name: 'Followers'),
  Geckoboard::NumberField.new(:popularity, name: 'Popularity'),
])

ARTIST_ID = "43ZHCT0cAZBISjO8DG9PnE"
spotify = Spotify.new(ARTIST_ID)

dataset.put([
  {
    followers: spotify.get_followers,
    popularity: spotify.get_popularity
  },
])