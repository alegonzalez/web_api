class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:create,:destroy]
	def index
		user  = User.all;
		render json: user, status: 200
	end
	#create a new user
	def create
		user = User.new(params_user)
		user.encryptionPassword(user)
		if user.save
			render nothing: true, status: 201
		else
			render json: user.errors, status: 422
		end	
	end
    #Allow only add 
    private
    def params_user
    	params.require(:user).permit(:username,:password,:firstname,:token,:creationDate)
    end



end
