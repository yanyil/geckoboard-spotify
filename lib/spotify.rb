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

  def get_top_tracks(country)
    format_top_tracks(country)
  end

  private

  def parse_request(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def get_artist
    url = "https://api.spotify.com/v1/artists/#{artist_id}"
    parse_request(url)
  end

  def format_top_tracks(country)
    url = "https://api.spotify.com/v1/artists/#{artist_id}/top-tracks?country=#{country}"
    output = []
    parse_request(url)["tracks"].each do |album|
      output << {track: album["name"], popularity: album["popularity"]}
    end
    output
  end
end