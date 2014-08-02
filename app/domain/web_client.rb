class WebClient
  require "net/http"
  require "uri"

  def get_response(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.request(Net::HTTP::Get.new(uri.request_uri))
  end
end