class SessionsController < ApplicationController
    def new 
        session[:session_token] = nil
        render :new
    end

    def create
        @user = User.find_by_credentials(params["session"]["email"], params["session"]["password"])
        login!(@user)
    end

    def destroy
        logout!(current_user)
        redirect_to new_session_url
    end

    
end