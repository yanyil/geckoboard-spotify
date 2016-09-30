require 'spotify'

describe Spotify do
  let(:artist_id) { "43ZHCT0cAZBISjO8DG9PnE" }
  subject(:spotify) { described_class.new(artist_id) }

  before do
    file_path = File.expand_path("support/artist.json", File.dirname(__FILE__))
    data = JSON.load(File.new(file_path))
    url = "https://api.spotify.com/v1/artists/#{artist_id}"

    stub_request(:get, url).to_return(
      status: 201,
      headers: {
        'Content-Type' => 'application/json'
      },
      body: data.to_json
    )
  end

  describe '#get_followers' do
    it 'returns the number of followers of the artist' do
      expect(spotify.get_followers).to eq 1205074
    end
  end

  describe '#get_popularity' do
    it 'returns the number of followers of the artist' do
      expect(spotify.get_popularity).to eq 76
    end
  end
end