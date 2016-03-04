class User < ActiveRecord::Base
	require 'digest/md5'
	#validates :username,:password presence: true
    #:token,:creationDate
    #set encryption of the password
    def encryptionPassword(user)
    	user.password = Digest::MD5.hexdigest(user.password)
    end
    #verification that the user not this repeated
   # def verificationUserNotRepit(user)
    #  user = searchUserByUsername(user)
    # if user.empty?
     # error.add(:user,"The username are repeated")
   #end
end
    #set encryption the date
    def encryptionDateForToken(user,userSearch)
    	user.creationDate = Time.now
        user.token = Digest::MD5.hexdigest(user.username)
        userSearch.update(:token => user.token, :creationDate =>user.creationDate)
    end

    #validate that password and user are equals
    def valid_user_password(user)
       user.password = encryptionPassword(user)
       userSearch =  searchUserByUsername(user)

       if userSearch.password == user.password
         encryptionDateForToken(user,userSearch)
     end 
 end
 def searchUserByUsername (user)
   User.find_by(username: user.username)     
end
end
