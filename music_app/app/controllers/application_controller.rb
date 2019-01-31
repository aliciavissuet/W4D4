class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :login!
    def login!(user)
        session[:session_token] = user.reset_session_token!
        redirect_to user_url(user)
    end

    def current_user
        @current_user ||=User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def logout!(user)
        user.reset_session_token!
        session[:session_token] = nil
    end
end
