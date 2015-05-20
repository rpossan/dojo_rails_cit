# config/initializers/her.rb
# Her::API.setup url: "https://api.example.com" do |c|
#   # Request
#   c.use Faraday::Request::UrlEncoded

#   # Response
#   c.use Her::Middleware::DefaultParseJSON

#   # Adapter
#   c.use Faraday::Adapter::NetHttp
# end

module Her
  module Middleware
    # This middleware adds a "Content-Type: application/json" HTTP header
    class JSONContentType < Faraday::Middleware
      # @private
      def add_header(headers)
        headers.merge! "Content-Type" => "application/json"
      end

      # @private
      def call(env)
        add_header(env[:request_headers])
        @app.call(env)
      end
    end
  end
end



SWAGGER = Her::API.new
SWAGGER.setup url: "http://poncio.cit:11081/apib2b-admin-api/api/" do |c|
  # Response
  c.use Faraday::Request::UrlEncoded
  c.use Her::Middleware::JSONContentType
  c.use Her::Middleware::DefaultParseJSON

  c.use Faraday::Request::BasicAuthentication, "admin", "admin"



  c.use Faraday::Response::Logger

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

# OTHER_API = Her::API.new
# OTHER_API.setup url: "https://other-api.example.com" do |c|
#   # Response
#   c.use Her::Middleware::DefaultParseJSON

#   # Adapter
#   c.use Faraday::Adapter::NetHttp
# end