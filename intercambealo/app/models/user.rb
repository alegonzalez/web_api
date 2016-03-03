class User < ActiveRecord::Base
	require 'digest/md5'
	
    #:token,:creationDate
    def encryptionPassword(user)
    	user.password = Digest::MD5.hexdigest(user.password)
    end
    def setToken(user)
    	#user.token = Digest::MD5.hexdigest(user.creationDate)
    	user.creationDate = DateTime.time.to_formatted_s(:rfc822)
    end
end
