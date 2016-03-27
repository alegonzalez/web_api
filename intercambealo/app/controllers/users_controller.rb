class UsersController < ApplicationController
 require 'time'
 before_action :set_users, only: [:destroy,:update]
 before_action :validate_token, only: [:create,:update,:destroy]
	#before_action :authenticate, only: [:show,:edit,:update,:destroy]
  skip_before_filter :verify_authenticity_token, only: [:create,:destroy,:authenticate,:update]
	#create a new user

	def create
		user = User.new(params_user)
		user.verificationUserNotRepit(user)

		if !user.errors{:username}.empty?
			render json:  user.errors, status: 422	
		else
			user.encryptionPassword(user)
			if user.save
				render nothing: true, status: 201
			else
				render json: user.errors, status: 422
			end	
		end
	end
    #update user
    def update
    	if @user.update(params_user)
    		render json: {"Message" => "Edit an specific user"},status: 200
    	else
    		render json: {"Message" => "The user can't edit"},status: 404
    	end
    end
  	#Delete users
  	def destroy
  		if @user.destroy
  			render json: {"Message" => "Deletes an specific user"}, status: 204
  		else
  			render json: {"Error" => "The user can't delete"}, status: 422
  		end
  	end
   #authenticate the user 
   def authenticate
   	@user = User.new(params_authenticate)
   	@user.valid_user_password(@user)
   	if @user.errors{:password}.empty? || @user.errors{:username}.empty?
   		session[:token] = @user.token
       session[:expires] = Time.now + 1.minute
       render json: {"Token" => session[:token]}, status: 200
     else
       render json: user.errors, status: 422
     end
   end
   #validate the token 
   def validate_token

    if(session[:expires]<Time.now)
      render json: {"Message" => "the session has expired, please log"} ,status: 402
    end
  end
    #get data the user 
    private
    def params_user
    	params.permit(:username,:password,:firstname,:token,:creationDate)
    end
    #Allow only the params indicated
    private 
    def params_authenticate
     params.require(:user).permit(:username,:password)
   end
    #search by id
    private 
    def set_users
    	@user = User.find(params[:id])
    end
  end
