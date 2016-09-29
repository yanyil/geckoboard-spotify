require 'geckoboard'
require 'dotenv'
Dotenv.load

API_KEY = ENV['GECKOBOARD_API_KEY']
client = Geckoboard.client(API_KEY)
p client.ping