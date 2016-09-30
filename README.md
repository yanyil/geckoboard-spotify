#Geckoboard-Spotify

[![Build Status](https://travis-ci.org/yyl29/geckoboard-spotify.svg?branch=master)](https://travis-ci.org/yyl29/geckoboard-spotify) [![Coverage Status](https://coveralls.io/repos/github/yyl29/geckoboard-spotify/badge.svg?branch=master)](https://coveralls.io/github/yyl29/geckoboard-spotify?branch=master)

A [Geckoboard](https://www.geckoboard.com/) integration using the [Spotify API](https://developer.spotify.com/web-api/). It allows users to monitor data of a Spotify artist.

[Dashboard sharing link](https://yanyili.geckoboard.com/dashboards/DDB34472BE57CCE3)

## Prerequisites
* Ruby 2.3.1

## Installation
From the command line:
```
$ git clone https://github.com/yyl29/geckoboard-spotify.git
$ cd geckoboard-spotify
$ bundle
```

Create a file `.env` in the root directory, then add your Geckoboard API key:
```
GECKOBOARD_API_KEY='your_api_key'
```

## Usage
Configure custom settings in `app.rb`. The defaults are set as follows:
```ruby
ARTIST_ID = "43ZHCT0cAZBISjO8DG9PnE" # Spotify artist id for Elvis Presley
COUNTRY = "GB" # Country code for top tracks
UPDATE_INTERVAL = '10m' # Geckoboard update interval
```

The artist id can be found in the url address of the artist's page. E.g. `43ZHCT0cAZBISjO8DG9PnE` for Elvis Presley(https://open.spotify.com/artist/43ZHCT0cAZBISjO8DG9PnE).

The country code is an [ISO 3166-1 alpha-2 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).

The update interval can have units in seconds, minutes, hours, days or weeks(s, m, h, d or w).

To run the app locally, run from the command line:
```
$ ruby app.rb
```

This will create a artist dataset (with the number of followers and popularity) and a top_tracks dataset (with top tracks of the artist and popularity of the tracks), you can then go to your dashboard to build some widgets from the datasets!

## Test
From the command line:
```
$ rspec
```

## Tools
This app is written in Ruby and uses the [Geckoboard Datasets API](https://developer.geckoboard.com/api-reference/ruby/) to integrate with the [Spotify API](https://developer.spotify.com/web-api/).

Ruby [Net::HTTP](http://ruby-doc.org/stdlib-2.3.1/libdoc/net/http/rdoc/Net/HTTP.html) is used to make HTTP request from Spotify API.

The following Ruby gems are also used:
* [dotenv](https://github.com/bkeepers/dotenv) - to store Geckoboard API key
* [rufus-scheduler](https://github.com/jmettraux/rufus-scheduler) - to schedule Geckoboard datasets update

The app is tested in Rspec. In order to stub external API services, I used the Ruby gem [webmock](https://github.com/bblimke/webmock) and [example json data](https://github.com/yyl29/geckoboard-spotify/tree/master/spec/support) (downloaded from real HTTP response) to control the responses.

## Possible future improvements
* Include a timestamp field so that data trend can be displayed over time
* Use Spotify OAuth to access more data
* Ability to include more artists