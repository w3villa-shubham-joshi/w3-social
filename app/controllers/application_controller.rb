class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # helper_method :current_user
  
    # def current_user
    #   if session[:user_id]
    #     @current_user  = User.find(session[:user_id])
    #   end
    # end

    # def log_in(user)
    #   session[:user_id] = user.id
    #   @current_user = user
    #   redirect_to root_path
    # end 

    # def logged_in?
    #   !current_user.nil?
    # end

    # def log_out
    #   session.delete(:user_id)
    #   @current_user = nil
    # end

    protected
    
    def configure_permitted_parameters
      added_attrs = [:firstname, :lastname, :username, :email, :password, :password_confirmation, :attachment, :remember_me, :login, :images]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
  end
