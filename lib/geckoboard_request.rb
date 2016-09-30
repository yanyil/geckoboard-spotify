require 'geckoboard'

class GeckoboardRequest
  attr_reader :client

  def initialize(api_key)
    @client = Geckoboard.client(api_key)
    @client.ping
  end

  def update(id, fields, data)
    dataset = client.datasets.find_or_create(id, fields: fields)
    dataset.put(data)
  end
end