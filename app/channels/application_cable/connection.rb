module ApplicationCable
  class Connection < ActionCable::Connection::Base
#Inside ActionCable we do not have access to :session, but we do have access to Cookies.
#Below, we have to identify who is using it. Which is our current chef. (logged in to work)
    identified_by :current_chef
    
    def connect
      self.current_chef = find_current_user
    end
    
    def disconnect
      
    end
    
    protected 
#This method returns the current user
    def find_current_user
#Below, "cookies.signed" = the cookies being passed to the client. This has to be set when chef logs 
#in (within "sessions_controller.rb")
      if current_chef = Chef.find_by(id: cookies.signed[:chef_id])
        current_chef #Then return current_chef
      else
        reject_unauthorized_connection
      end
    end
  end
end
