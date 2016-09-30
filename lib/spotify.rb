require 'net/http'
require 'json'

class Spotify
  attr_reader :artist_id

  def initialize(artist_id)
    @artist_id = artist_id
  end

  def get_followers
    get_artist["followers"]["total"]
  end

  def get_popularity
    get_artist["popularity"]
  end

  private

  def get_artist
    url = "https://api.spotify.com/v1/artists/#{artist_id}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end