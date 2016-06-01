require 'rubygems'
require 'twilio-ruby' 

class NumbersController < ApplicationController
    skip_before_filter :verify_authenticity_token, :only => [:create]

	# put your own credentials here 
	@account_sid = 'AC7ffe0262875158a08c112f7f3f60958c' 
	@auth_token = 'd74c5e365402e45c11a686a3ac4e1430' 

    def index
		@numbers = Number.all
	end

	def new
		@number = Number.new
	end

	def create
		account_sid = 'AC7ffe0262875158a08c112f7f3f60958c' 
		auth_token = 'd74c5e365402e45c11a686a3ac4e1430' 

		to_number = Number.create(params[number_params])
		p to_number
		# set up a client to talk to the Twilio REST API 
		@client = Twilio::REST::Client.new account_sid, auth_token 

		@twilio_number = '+19148882435'
		@client.account.messages.create({
		  :from => @twilio_number, 
		  :to => to_number, 
		  :body => 'hey, it works!', 
		})
	end

	def number_params
		params.require(:number)
	end


	# caller_id = @client.account.outgoing_caller_ids.create({
	# 	:phone_number => 'from_number',   
	# 	:friendly_name => 'Texty Text'
	# }) 

end
