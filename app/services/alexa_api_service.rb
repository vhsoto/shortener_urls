class AlexaApiService
  require 'excon'
  
  def request_api(url)
    host = URI.parse(url).host
    base_url = "https://awis.api.alexa.com/api?Action=UrlInfo&ResponseGroup=Rank&Output=json&Url=#{host}"
    response = Excon.get(
      base_url,
      headers: {
        'x-api-key' => '8T7SlYd7Tp16a9VPBovC26LXGhosXjeM97CLbUUv'
      }
    )

    return nil if response.status != 200

    JSON.parse(response.body)
  end
end
