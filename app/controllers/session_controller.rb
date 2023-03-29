class SessionController < ApplicationController
    # def omniauth
    #     user = User.from_omniauth(auth)
    
    #     if user.present?
    #       sign_out_all_scopes
    #       flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
    #       sign_in_and_redirect user, event: :authentication
    #     else
    #       flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
    #       redirect_to new_user_session_path
    #     end 
    #   end

    def create
        user = User.find_by(username: params[:session][:username])
        if user
          log_in(user)
        else
          render 'new'
        end
    end
    
      def destroy
        log_out if logged_in?
        redirect_to root_path
      end

end