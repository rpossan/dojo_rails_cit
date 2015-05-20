require 'her'
require_relative 'her_config'

Core::Application.routes.draw do
  mount Swagencies::Engine => '/swagencies'
end


module Swagencies
	class API
		include Her::Model
		collection_path "agencies"

		use_api SWAGGER

		def self.get_all
		    get_raw("agencies") do |parsed_data, response|
		      parsed_data[:data][:data][:list]
		    end
		end

	end
end
