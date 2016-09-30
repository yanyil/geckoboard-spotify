require 'spotify'

describe Spotify do
  let(:artist_id) { "43ZHCT0cAZBISjO8DG9PnE" }
  subject(:spotify) { described_class.new(artist_id) }

  context 'when artist' do
    before do
      url = "https://api.spotify.com/v1/artists/#{artist_id}"
      file_path = File.expand_path("support/artist.json", File.dirname(__FILE__))
      stub_endpoint(url, file_path)
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

  context 'when top tracks' do
    before do
      url = "https://api.spotify.com/v1/artists/#{artist_id}/top-tracks?country=GB"
      file_path = File.expand_path("support/top_tracks.json", File.dirname(__FILE__))
      stub_endpoint(url, file_path)
    end

    describe '#get_top_tracks' do
      it 'returns an array of the top tracks of the artist' do
        top_track = {track: "Can't Help Falling in Love", popularity: 69}
        expect(spotify.get_top_tracks("GB").first).to eq top_track
      end
    end
  end

  def stub_endpoint(url, file_path)
    data = JSON.load(File.new(file_path))

    stub_request(:get, url).to_return(
      status: 201,
      headers: {
        'Content-Type' => 'application/json'
      },
      body: data.to_json
    )
  end
end