# config/initializers/her.rb
Her::API.setup url: "https://api.example.com" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

SWAGGER = Her::API.new
SWAGGER.setup url: "http://poncio.cit:11081/apib2b-admin-api/swagger/../api/../api/" do |c|
  # Response
  c.use Her::Middleware::DefaultParseJSON

  c.use Faraday::Request::BasicAuthentication, "admin", "admin"

  c.use Faraday::Request::UrlEncoded

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

OTHER_API = Her::API.new
OTHER_API.setup url: "https://other-api.example.com" do |c|
  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end