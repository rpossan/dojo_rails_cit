require 'net/http'
require 'openssl'
require 'uri'
require 'json'

class Proxy2

	def self.http_get(path, params = nil)
		uri = URI.parse(URI.encode(get_url(path, params).strip))
		path = (uri.query.blank? ? uri.path : "#{uri.path}?#{uri.query}")
		Rails.logger.info "PROXY GET para #{uri.path}"
		req = Net::HTTP::Get.new(path)
		add_headers req
		http = Net::HTTP.new(uri.host, uri.port)

	    if (uri.port == 443)
	      http.use_ssl = true
	      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	    end

	    res = http.request(req)

	    message_from_response(res)

	end


	def self.add_headers(req)
		req.basic_auth APP_CONFIG['login_api'], APP_CONFIG['password_api']
		#req.add_field("User-Token", UserInfo.current_user.http_token) if (!UserInfo.current_user.blank?)
	end

  def self.get_url path, params = nil
    "#{APP_CONFIG['url_api']}/#{get_path_with_params(path, params)}"
  end

  def self.get_path_with_params path, params = nil
    return path if (params.blank?)

    query_string_params = {}

    if (!params.blank?)
      params.each do |key, value|
        if (path.include?("{#{key}}"))
          path.gsub!("{#{key}}", format_value(value))
        else
          query_string_params[key] = value
        end
      end
    end

    "#{path}#{query_string_params(query_string_params)}"
  end

  def self.query_string_params params
    return '' if (params.blank?)

    result = '?'

    params.each do |key, value|
      result += '&' if (result != '?')
      result += "#{key}=#{format_value(value)}"
    end

    result
  end

  def self.message_from_response res
    result = ''
    Rails.logger.info "API returned http status code #{res.code}"
    if (res.code == '200' && !res.body.to_s.blank?)
      result = JSON.parse(res.body.to_s)
    elsif (res.code == '225')
      error_dto = JSON.parse(res.body.to_s)
      if error_dto.is_a?(Array)
        raise Api::DomainException.new(res.body.to_s)
      else
        raise Api::DomainException.new(error_dto['result'])
      end
    elsif (res.code == '403')
      raise "Forbidden :("
    elsif (res.code == '500')
      raise "The API returned a 500 error :("
    elsif (res.code == '502')
      raise "Bad Gateway - API unreached :("
    elsif (res.code == '504')
      raise "Gateway Timeout - API has not returned a response :("
    end
    result
  end

end