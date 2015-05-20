require 'grape'

module ApiTest
	 
	 class API < Grape::API

    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api


    resource :status do

  		get do
  			{status: [{comment: "aaa"}, {comment: "bbb"}, {comment: "ccc"}]}
			end

    	desc 'Resource teste'
    	get :last do
    		#Implementacao do retorno
    		{status: [{comment: "aaa"}, {comment: "bbb"}, {comment: "ccc"}]}

  		end

  	end

	 end

end