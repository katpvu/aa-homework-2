class ApplicationController < ActionController::API
    include ActionController::RequestForgeryProtection

    protect_from_forgery with: :exception

    #before_action: runs before any controller actions run
    before_action :snake_case_params 
    before_action :attach_authenticity_token

    #--------------------------------------------------------
    #CRRLLL
    def current_user
        @current_user ||= User.find_by(session_token: session[session_token])
    end

    def require_logged_in
        if !logged_in?
            #--------------------this is different-------------------
            render json: { errors: ["Must be logged in"] }, status: :unauthorized
            #--------------------------------------------------------
        end
    end

    def require_logged_out
        if logged_in?
            #--------------------this is different-------------------
            render json: { errors: ["Must be logged out"]}, status: 403
            #--------------------------------------------------------
        end
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
    end


    #--------------------------------------------------------
    private

    #transforms something from camelCase to snake_case
    def snake_case_params
        params.deep_transform_keys!(&:underscore)
    end

    #generating an authenticity token and setting it in our headers
    def attach_authenticity_token
        headers['X-CSRF-Token'] = masked_authenticity_token(session)
    end
end
