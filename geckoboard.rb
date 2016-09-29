require 'geckoboard'
require 'dotenv'
Dotenv.load

API_KEY = ENV['GECKOBOARD_API_KEY']
client = Geckoboard.client(API_KEY)
client.ping

dataset = client.datasets.find_or_create('artist', fields: [
  Geckoboard::NumberField.new(:followers, name: 'Followers'),
  Geckoboard::NumberField.new(:popularity, name: 'Popularity'),
])

dataset.put([
  {
    followers: 1000000,
    popularity: 50
  },
])