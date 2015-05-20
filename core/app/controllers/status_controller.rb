class StatusController < ApplicationController

	def index
		#@status = Proxy.http_get("api/status")
		@agencias = Swagencies::API.get_all
	end

end
