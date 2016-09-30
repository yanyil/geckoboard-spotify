require 'geckoboard'
require 'dotenv'
require 'rufus-scheduler'
require_relative 'spotify'

API_KEY = Dotenv.load['GECKOBOARD_API_KEY']
ARTIST_ID = "43ZHCT0cAZBISjO8DG9PnE"
INTERVAL = '2s'

client = Geckoboard.client(API_KEY)
client.ping

spotify = Spotify.new(ARTIST_ID)

scheduler = Rufus::Scheduler.new

scheduler.every INTERVAL do
  dataset = client.datasets.find_or_create('artist', fields: [
    Geckoboard::NumberField.new(:followers, name: 'Followers'),
    Geckoboard::NumberField.new(:popularity, name: 'Popularity'),
  ])

  dataset.put([
    {
      followers: spotify.get_followers,
      popularity: spotify.get_popularity
    },
  ])
  puts 'Data added'
end

scheduler.join