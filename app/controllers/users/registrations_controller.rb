class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_permitted_parameters
  def update

    if business_downgrade_request?
      process_business_downgrade
    else
      super
    end

    current_user.update(user_params)
  end
  def destroy
    current_user.oauth_identities.destroy_all if current_user.respond_to?(:oauth_identities)
    current_user.destroy! 
    sign_out current_user
    redirect_to root_path, notice: "Account eliminato definitivamente"
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:business, :card_number, :card_expiry, :card_cvc, :username, :phone_number, :email, :password, :password_confirmation, :current_password])
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
  end

  private


  def user_params
    params.require(:user).permit(:discount_notifications, :structure_notifications)
  end

  def business_downgrade_request?
    params[:user][:business_downgrade] == 'true' || 
    params[:commit] == "Torna a Account Normale"
  end

  def process_business_downgrade
    if current_user.valid_password?(params[:user][:current_password])
      current_user.update(business: false)
      set_flash_message! :notice, :business_downgraded
      redirect_to root_path
    else
      clean_up_passwords(current_user)
      current_user.errors.add(:current_password, :invalid)
      render :edit
    end
  end
end