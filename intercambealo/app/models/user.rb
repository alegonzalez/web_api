class User < ActiveRecord::Base
	require 'digest/md5'  
	validates :username, presence: {:message => "The camp name is required"}
  validates :password, presence: {:message => "The camp password is required"}
  #validates :firsname, presence: {:message => "The camp firsname is required"}
    #:token,:creationDate
    #set encryption of the password
    def encryptionPassword(user)
    	user.password = Digest::MD5.hexdigest(user.password)
    end
    #verification that the user not this repeated
    def verificationUserNotRepit(user)
      userp = searchUserByUsername(user)
      if !userp.nil?
      user.errors.add(:username,"The user is repeated, please introdeced other")
      end
    end
   
    #set encryption the date
    def encryptionDateForToken(user,userSearch)
    	user.creationDate = Time.now
      user.token = user.creationDate #Digest::MD5.hexdigest(user.creationDate.to_s)
      userSearch.update(:token => user.token, :creationDate => user.creationDate)
    end

    #validate that password and user are equals
    def valid_user_password(user)
     user.password = encryptionPassword(user)
     userSearch =  searchUserByUsername(user)
     if !userSearch.nil?
       if userSearch.password == user.password
         encryptionDateForToken(user,userSearch)
       else
        user.errors.add(:password,"The password is not valid")
      end 
    else
      user.errors.add(:username,"The username is not valid")
      user.errors.add(:password,"The password is not valid")
    end
  end
  def searchUserByUsername (user)
   User.find_by(username: user.username)     
 end
end
