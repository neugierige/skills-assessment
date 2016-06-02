class NumbersController < ApplicationController
    before_action :set_number, only: [:show, :edit, :update, :destroy]

    def index
		@numbers = Number.all
	end

	def new
		@number = Number.new
	end

	def show
    end

    def edit
    end

	def create
		account_sid = 'AC7ffe0262875158a08c112f7f3f60958c' 
		auth_token = 'd74c5e365402e45c11a686a3ac4e1430' 

		@from_number = '+19148882435'
		@number = Number.new(number_params)
	
		@client = Twilio::REST::Client.new account_sid, auth_token 

		@twilio_number = @from_number
		@client.account.messages.create({
		  :from => @twilio_number, 
		  :to => @number.tocall, 
		  :body => 'hey, it works!', 
		})

		respond_to do |format|
	      if @number.save
	        format.html { redirect_to @number, notice: 'Number was successfully created.' }
	        format.json { render :show, status: :created, location: @number }
	      else
	        format.html { render :new }
	        format.json { render json: @number.errors, status: :unprocessable_entity }
	      end
	    end
	end

  def destroy
    @number.destroy
    respond_to do |format|
      format.html { redirect_to numbers_url, notice: 'Number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number
      @number = Numbers.find(params[:id])
    end


	def number_params
		params.require(:number).permit(:tocall)
	end


end
