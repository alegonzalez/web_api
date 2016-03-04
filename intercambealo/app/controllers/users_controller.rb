class UsersController < ApplicationController
	#before_action :authenticate, only: [:show,:edit,:update,:destroy]
	skip_before_filter :verify_authenticity_token, only: [:create,:destroy,:authenticate]

	def index
		user  = User.all;
		render json: user, status: 200
	end
	#create a new user

	def create
		
		user = User.new(params_user)
		#if user.verificationUserNotRepit(user)
		#	render json: user.errors, status: 422
		#else
			user.encryptionPassword(user)
			if user.save
				render nothing: true, status: 201
			else
				render json: user.errors, status: 422
			end	
		#end
	end

	#authenticate the user 
	
	def authenticate
		user = User.new(params_authenticate)
		
		if user.valid_user_password(user)
			render json: user , status: 200
		else
			render json: "Sorry the user not exist", status: 422
		end
	end
    #Allow only add 
    private
    def params_user
    	
    	params.require(:user).permit(:username,:password,:firstname,:token,:creationDate)
    end
    private 
    def params_authenticate
    	params.require(:user).permit(:username,:password)
    end
    
end
