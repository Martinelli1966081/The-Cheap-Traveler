# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    
    if @user.persisted?
      sign_in_and_redirect @user
    else
      Rails.logger.error "OAuth Validation Errors: #{@user.errors.full_messages}"
      redirect_to new_user_registration_url, 
        alert: "Errore: #{@user.errors.full_messages.to_sentence}"
    end
  end
end