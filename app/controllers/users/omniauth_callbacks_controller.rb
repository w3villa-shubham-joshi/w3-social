# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def passthru
#     render status: 404, plain: "Not found. Authentication passthru."
#   end
# class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   binding.pry
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  # def facebook
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authenticatgoogle_oauth2ion #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
  #     redirect_to new_user_registration_url
  #   end
  # end


  def google_oauth2
    # binding.pry
    user = User.from_omniauth(auth)
    if user.present?
      # flash[:success] = 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      # flash[:alert] = 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end


  private 

  def auth 
    @auth ||= request.env['omniauth.auth']
    # binding.pry
  end
     
end
