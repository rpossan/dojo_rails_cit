class StatusController < ApplicationController

	def index
		@status = Proxy.http_get("api/statuses/public_timeline")
	end

end
